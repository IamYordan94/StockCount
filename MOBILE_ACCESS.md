# 📱 How to Access the App on Your Phone

## Quick Steps

1. **Make sure your phone and computer are on the same Wi-Fi network**

2. **Start the dev server with network access:**
   ```bash
   npm run dev:network
   ```
   
   Or if you prefer to use the regular dev command, you can also run:
   ```bash
   next dev -H 0.0.0.0
   ```

3. **Find your computer's IP address:**
   - Your IP address is: **192.168.0.3** (from the check we just ran)
   - If you need to find it again, run: `ipconfig` (Windows) and look for "IPv4 Address"

4. **Open on your phone:**
   - Open your phone's browser (Chrome, Safari, etc.)
   - Go to: **http://192.168.0.3:3000**
   - The app should load!

## Troubleshooting

### Can't connect?
1. **Check Windows Firewall:**
   - Windows might block the connection
   - Go to: Windows Security → Firewall & network protection
   - Click "Allow an app through firewall"
   - Make sure Node.js is allowed (or temporarily disable firewall for testing)

2. **Check your network:**
   - Make sure both devices are on the same Wi-Fi network
   - Some public Wi-Fi networks block device-to-device communication

3. **Try a different port:**
   - If port 3000 is blocked, you can use a different port:
   ```bash
   next dev -H 0.0.0.0 -p 3001
   ```
   - Then access: `http://192.168.0.3:3001`

4. **Check the dev server:**
   - Make sure the server is running
   - You should see: "Ready - started server on 0.0.0.0:3000"

### Alternative: Use ngrok (for testing from anywhere)
If you want to test from outside your network (e.g., from a different location):

1. Install ngrok: https://ngrok.com/download
2. Run: `ngrok http 3000`
3. Use the ngrok URL on your phone (works from anywhere!)

## Notes

- The IP address (192.168.0.3) might change if you reconnect to Wi-Fi
- If it changes, just run `ipconfig` again to find the new IP
- The app is mobile-responsive, so it should work great on your phone!

