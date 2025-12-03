import * as XLSX from 'xlsx'

export interface ExcelRow {
  productinformatie: string
  verpakkingsEenheid: string
  aantal: number
  losseStuks: number
  category: string
}

export interface ParsedSheet {
  shopName: string
  items: ExcelRow[]
  errors: string[]
}

export function parseExcelFile(file: File): Promise<Map<string, ParsedSheet>> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    
    reader.onload = (e) => {
      try {
        const data = new Uint8Array(e.target?.result as ArrayBuffer)
        const workbook = XLSX.read(data, { type: 'array' })
        const sheets = new Map<string, ParsedSheet>()

        workbook.SheetNames.forEach((sheetName) => {
          const worksheet = workbook.Sheets[sheetName]
          const jsonData = XLSX.utils.sheet_to_json(worksheet, { 
            header: ['productinformatie', 'verpakkingsEenheid', 'aantal', 'losseStuks'],
            defval: '',
            raw: false
          }) as any[]

          const items: ExcelRow[] = []
          const errors: string[] = []
          let currentCategory = ''

          // Skip header row and process data
          for (let i = 1; i < jsonData.length; i++) {
            const row = jsonData[i]
            
            if (!row || !row.productinformatie) continue

            const productInfo = String(row.productinformatie || '').trim()
            
            // Check if this is a category header (bolded rows in Excel are often all caps or specific format)
            // Category headers are typically in the first column and might be in all caps
            if (productInfo && 
                (productInfo === productInfo.toUpperCase() || 
                 ['IJSJES', 'DRANK', 'ETEN', 'Stromma branded', 'Cheese'].includes(productInfo))) {
              currentCategory = productInfo
              continue // Skip category header rows
            }

            // Skip empty rows
            if (!productInfo) continue

            const verpakkingsEenheid = String(row.verpakkingsEenheid || '').trim()
            
            // Parse quantities - handle empty cells, text, and numbers
            let aantal = 0
            let losseStuks = 0

            try {
              const aantalStr = String(row.aantal || '').trim()
              aantal = aantalStr === '' ? 0 : parseInt(aantalStr, 10) || 0
            } catch (e) {
              errors.push(`Row ${i + 1}: Invalid "Aantal" value: ${row.aantal}`)
            }

            try {
              const losseStuksStr = String(row.losseStuks || '').trim()
              losseStuks = losseStuksStr === '' ? 0 : parseInt(losseStuksStr, 10) || 0
            } catch (e) {
              errors.push(`Row ${i + 1}: Invalid "Losse stuks" value: ${row.losseStuks}`)
            }

            items.push({
              productinformatie: productInfo,
              verpakkingsEenheid,
              aantal,
              losseStuks,
              category: currentCategory || 'Uncategorized'
            })
          }

          sheets.set(sheetName, {
            shopName: sheetName,
            items,
            errors
          })
        })

        resolve(sheets)
      } catch (error) {
        reject(error)
      }
    }

    reader.onerror = () => reject(new Error('Failed to read file'))
    reader.readAsArrayBuffer(file)
  })
}

