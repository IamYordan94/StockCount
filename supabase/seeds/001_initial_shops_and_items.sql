-- Seed data generated from Excel file: Stock take October.xlsx
-- Generated on: 2025-12-04T14:40:08.851Z

-- Insert Shops
-- IMPORTANT: If shops already exist with different IDs, uncomment the next 2 lines:
-- DELETE FROM shop_stock;
-- DELETE FROM shops;
-- Otherwise, the seed will use COALESCE to find existing shop IDs automatically.

INSERT INTO shops (id, name, created_at) VALUES ('8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6', 'Winkel Rijks', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('8239c24e-92f4-4140-830c-94c014639381', 'Ponton Rijks', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('fceef697-1ef9-49d3-9308-023ba61c2cbe', 'ARK Rijks', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('0189fb6a-7228-4bec-8baf-3d274c3dcc17', 'Leidse', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('8cd447eb-ca21-4ba1-8b03-f308b211f8eb', 'CS Oost', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('e06f3d74-8099-4d3f-9f67-f858fe5b689c', 'Bridge', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('5825609a-fb44-442b-9d24-a40136a057b6', 'Damrak 5', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('ce8b3886-03b8-4922-98e1-b3e974f57082', 'Damrak 6', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('c410a3da-a83a-430a-9aa9-7c13a26f7345', 'Vlaggenwinkel', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('3b9f0f1d-bca1-449e-9e3e-97ea70956d40', 'Damrak 4', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;
INSERT INTO shops (id, name, created_at) VALUES ('8054fcba-d23a-4764-bce9-8280648c8974', 'VC', NOW()) ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name;

-- Insert Items

INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('5cacea9f-000a-4a2b-9449-da7976ec9a55', 'OLA Raket', 'IJSJES', 'per 54 a 55 ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a7c39d48-b92c-427b-93dc-87a3a334d0f8', 'OLA Donut', 'IJSJES', 'per 54 a 55 ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 'OLA Dracula', 'IJSJES', 'per 35 x 50ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 'OLA Super Twister', 'IJSJES', 'per 24 a 120ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 'OLA Magnum Classic', 'IJSJES', 'per 20 a 110 ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 'OLA Magnum Almond', 'IJSJES', 'per 20 a 120 ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('135cf50b-905c-4a56-8d09-8fa3f9937ad0', 'OLA Magnum White', 'IJSJES', 'per 20 a 120 ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('457024a9-9985-4aaa-bed4-e6f9167e4d16', 'OLA Cornetto Classico', 'IJSJES', 'per 20 a 85ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('f48cf38a-10ed-44d2-9422-dc0df82f572f', 'Heineken blik 33CL', 'DRANK', 'per 24 blikjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('6677c335-23d4-4681-b8c0-a099313e56eb', 'Heineken blik 0,0 %  33CL', 'DRANK', 'per 24 blikjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('426730a7-c37b-4e8e-9dcc-307df00b8fa0', 'Desperados 33CL', 'DRANK', 'per 24 blikjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a1c46ba3-b912-46b1-9162-ab268e738f00', 'La Croisade chardonnay grenache 25 CL', 'DRANK', 'per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('7547ba73-a094-4355-ac54-54e3e1afca20', 'La Croisade merlot rouge 25CL', 'DRANK', 'per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('081ce98e-859a-424a-9d73-17eb89b16091', 'La Croisade rosé 25CL', 'DRANK', 'per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 'Lisetto Prosecco Klein flesje 20CL', 'DRANK', 'per 12 flesjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('703eb54d-f2e0-4c59-b62c-2a0cb6adf7fb', 'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('db0b774c-5ea1-4f12-b9d4-7ac5a16e374f', 'Sourcy Rood pet 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('3c8fe1c2-a129-4219-8130-060991c3fbe2', 'Sourcy Vitamin Water Braam Acai 0% 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('abc5f330-7711-4069-931e-196494f57a7f', 'Sourcy Vitamin Water DruifCitroen 0% 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('31841a68-7c29-4f8c-a533-a8813d0e9886', 'Sourcy Vitamin Water Mango Guave 0% 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('5751fac6-b7e7-49b1-a5f7-60c98bf1aed1', 'Rivella 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('2b0674c2-6d99-4922-a220-266c846cf858', 'Ranja fruitmix aardbei/framboos 33CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ec4c0b9b-a4ec-4854-8b13-ab33eccc7fae', 'Lipton Ice Tea Sparkling petfles 50 cl', 'DRANK', 'per 12 flesjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('efb380a6-241a-4634-bb3e-bd570309446a', 'Lipton Ice Tea peach/green Zero 50 cl', 'DRANK', 'per 12 flesjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('449dbbc4-a928-4483-abee-c7520abdfba9', 'Pepsi petfles regular 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('d60b2130-9793-44c0-bc6a-dc594eccbf3b', 'Pepsi petfles max 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('83544023-ac5d-49df-8709-db88c5f34e1c', 'Seven Up suikervrij 50 CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('2a482631-ad4c-46c4-ac57-e9fe60a3b1d2', 'Sisi suikevrij 50CL', 'DRANK', 'per 6 pieces', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('e3b460f3-7b85-46c4-9fb5-46a99f17128b', 'Rockstar original regular/suikervrij (blik) 25CL', 'DRANK', 'per 12 blikjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ab7b449e-1386-47d8-a46d-ada9f8415012', 'Lay''s zakje chips naturel/paprika/bolognese', 'ETEN', 'doos per 20 zakjes a 40 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('2b0d382f-1fc5-4fb7-a833-07090409396a', 'Pringles Original/Sourcream/Hot', 'ETEN', 'tray 12 blikjes a 40 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('09465f93-182f-4bdc-8130-02a19206d711', 'Haribo Starmix 75 gram', 'ETEN', 'doos 28 zakjes a 75 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('0046c08a-02d8-4221-8ef3-5664b6820b7c', 'Daelmans stroopwafels jumbo single', 'ETEN', 'doos 36 stuks a 39 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('0a47c79c-8435-457d-9d8d-389c1f780768', 'Milky way single reep', 'ETEN', 'doos 28 stuks a 43 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a7ae210d-3751-4598-9458-882191214b2c', 'M&m''s pinda single', 'ETEN', 'doos 24 zakjes a 45 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('46b74937-eb06-4119-9abb-17221e73dc93', 'Mars single reep', 'ETEN', 'doos 32 stuks a 51 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('52d4fe38-2b2d-41bf-932b-2761dc6639c9', 'Snickers single reep', 'ETEN', 'doos 32 stuks a 50 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('8cbf44c9-12d5-479e-9174-145c28810778', 'Twix single reep', 'ETEN', 'doos 25 stuks a 50 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 'KitKat chocobar', 'ETEN', 'doos 36 stuks a 41,5 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('7ef2e565-acfc-4cf0-b7db-7c494b33981e', 'Oud hollandse candy’s', 'Stromma branded', 'dos 60 stucks a 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('22c68ff3-4fc4-43d4-94eb-7f37f48d6b62', 'Stroopwafel zakje', 'Stromma branded', 'dos 60 stucks a 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('faca5bd1-c10e-4809-b203-2f1744993f93', 'Stroopwafel koker yellow box', 'Stromma branded', 'dos 60 stucks a 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('0203e781-d863-402c-abfb-13203529c7b2', 'Pretzel', 'Stromma branded', 'dos 60 stucks a 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a85d8cd3-9f3a-4c85-8e09-df26c58fc7c7', 'Huismix', 'Stromma branded', 'dos 60 stucks a 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('09096d6a-ad7e-43b3-a456-de20f33d1fe6', 'Cubes Mature/ 4-6 months', 'Cheese', 'per 12 x 135g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a04fd71c-f4a6-4ef8-8de9-448e917099d4', 'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('63610cb9-1ba5-4b69-b3ed-60bae096222b', 'Sourcy Rood pet 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('92b97db6-0312-4877-a610-7fb9a7f42a5c', 'Sourcy Vitamin Water Braam Acai 0% 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 'Sourcy Vitamin Water DruifCitroen 0% 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 'Sourcy Vitamin Water Mango Guave 0% 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 'Rivella 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('64c9449b-9eb2-4522-a241-29ee77afdfff', 'Ranja fruitmix aardbei/framboos 33CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 'Lipton Ice Tea Sparkling petfles 50 cl', 'DRANK SHOP', 'per 12 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 'Lipton Ice Tea peach/green Zero 50 cl', 'DRANK SHOP', 'per 12 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('7d2a9798-a303-461e-8487-be1fe9d66672', 'Pepsi petfles regular 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('b776cec8-ab31-48e7-9192-e7ce3a03a106', 'Pepsi petfles max 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('786ac8a5-6797-461e-8480-5e7f6bccdc59', 'Seven Up suikervrij 50 CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('380eb32b-e93d-4a94-a97e-4e1105559fe4', 'Sisi suikevrij 50CL', 'DRANK SHOP', 'per 6 flesjes ex emb €0,15 per fles', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('b3d44307-d86f-41ec-9258-2fd89869807f', 'Segura Viudas Cava Brut Fles 75 cl', 'DRANK CATERING', 'per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('dda14fe7-65e7-4df6-a89a-5191c6845d8f', 'Marival Rose 75 cl', 'DRANK CATERING', 'per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('98bce447-ec04-4711-9e03-d869b615555c', 'Lisetto Prosecco Spumante Fles 75 cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a0785b8b-ddd7-4046-b89c-c20c08530640', 'Laroche Wit Chardonnay Fles 75 cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ac6c0fa3-db11-4736-8919-653e86b4cc5c', 'Laroche Rood Merlot Fles 75 cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('6a186a6b-859c-4584-aa68-e5f296b1f85e', 'Laroche Rose Fles 75 cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('8e4c8e00-03b3-4a50-9e07-31e68bcd2a3c', 'La Croisade Chardonnay grenache 75cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('19cad202-8144-48c9-8d13-eb2d2e611c40', 'La Croisade Merlot rouge 75cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('bbd78e91-1c81-4ade-a48d-f39776c670b7', 'La Croisade Rosé 75cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('95025844-a345-4c12-a40b-291344e087ad', 'Heineken Pilsener Star Bottle krat', 'DRANK CATERING', 'per krat 24 stuks x 30cl', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('6719141a-ddc0-44f3-b839-34ba6fbae05e', 'Heineken 0.0% Krat', 'DRANK CATERING', 'per krat 24 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('41f745e5-fd8f-407d-a566-f5054db53180', 'Sourcy Rood mineraalwater 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('de44cc49-ad63-4848-b04f-1416cd27b14b', 'Sourcy Natuurlijk mineraalwater koolzuurvrij fles 20 cl krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('1883ee58-52bb-41aa-96f9-63cb5aef10ee', 'Pepsi Regular cola 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('9792062f-1af1-4789-8c7a-476521078cd8', 'Pepsi Max cola 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('d2c10e25-1bcf-4210-8e87-cdd3f306cf65', '7 Up Free 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ea0878ef-e50c-46cf-ae3e-b28e8c621fc4', 'Sisi Suikervrije Sinas 20cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('c3262fde-9825-4860-abe5-04790dddc241', 'Lipton Ice tea green 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('cb043a72-82d3-4a44-b539-5175833c75b6', 'Royal Club Sinaasappelsap 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('033f2d59-5c6b-49bc-8385-65f1e00bd90c', 'Royal Club Appelsap 20 cl fles krat', 'DRANK CATERING', 'per krat 28 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('2f19f558-1d43-43c5-bd47-3572e6d6aa2f', 'Sourcy Natuurlijk mineraalwater koolzuurvrij 75 cl', 'DRANK CATERING', 'krat per 12', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('950bf091-cf3b-4d64-b798-f01f7e2c457d', 'Sourcy Rood mineraalwater 75 cl', 'DRANK CATERING', 'krat per 12', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 'Duyvis Pinda''s gezouten nootjes', 'ETEN', 'doos 20 zakjes a 60 gr', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('553f6cbd-7ccc-4438-97e3-9be96bef5525', 'Kaasblokjes - jong', 'ETEN CATERING', '', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('894b60a4-a8cd-4185-9307-7f9d253a1cdf', 'Kaasblokjes - oud', 'ETEN CATERING', '', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('d4facbf9-1657-466c-bbf9-b86b6362b606', 'Komijn - blokjes', 'ETEN CATERING', '', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('26579898-f9c2-49ae-8514-6020bafa5c8e', 'Daelmans Mini stroopwafel blokzak', 'ETEN CATERING', 'per doos a 6 stuks a 400g', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('679eb1ed-cb86-464a-9a82-a0914d111f2c', 'Daelmans Mini stroopwafels Doos 2,5 kilo', 'ETEN CATERING', 'per doos 200 stuks a 8g', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('971de9a5-667d-44c4-a4c0-1a86c97ed6c5', 'Leev Stroopwafel bio glutenvrij', 'ETEN CATERING', '16 wikkels a 60g', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('2c37abfb-592e-4ca9-8f7e-df1e41d7aa65', 'Daendels Hotmix van rijstzoutjes en gecoate pinda''s Emmer 5 kilo', 'ETEN CATERING', 'per emmer 5 kilo', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('4eda1a7c-0517-456d-855f-d22bb2736278', 'Daendels Roomboter kaasvlinders Emmer 750 gram', 'ETEN CATERING', 'per emmer 750 gram', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('44e94a0d-fd32-4824-8993-e2a5dc0d0f87', 'Pickwick Theezakjes Earl Grey Met Envelop Pak 100 zakjes x 2 gram', 'ETEN CATERING', 'per 100 stuks a 2g', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ab16c8fa-d0ae-4972-a2a3-e8e76370057a', 'Pickwick Theezakjes Green Lemon Met Envelop Pak 100 zakjes x 2 gram', 'ETEN CATERING', 'per 100 stuks a 2g', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('5903ef07-d99b-41a6-bd00-c48ad5d93f5a', 'Pickwick Theezakjes Bosvruchten Met Envelop Pak 100 stuks x 1,5 gram', 'ETEN CATERING', 'per 100 stuks a 1,5g', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('5fb6e52d-af6f-497e-883d-6d5a9f6b4c33', 'Apollo Zwarte pepermolen', 'ETEN CATERING', 'per 6 stuks x 45 gr', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('c4c27088-b76e-4fdd-8487-e5d4ed92da39', 'Apollo Zeezoutmolen', 'ETEN CATERING', 'per 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('85398b8c-cf7c-4b88-bea1-3fbc558e9ac1', 'Hekos Spekkoek 570gr', 'ETEN CATERING', 'per box', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a1c0afae-aa17-4ddf-b752-17b0d1403f30', 'Ola Donut', 'IJSJES', 'per 54 a 55 ml', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('cbbee67d-3565-4917-aff4-3741bb0cde37', 'Oud hollandse candy’s', 'Stromma branded', '60 pieces per 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a095faa5-e77d-4fcc-8c76-524cc67b1b68', 'Stroopwafel zakje', 'Stromma branded', '60 pieces per 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('9ccdaefc-a0de-4882-a058-6508b7b46a91', 'Stroopwafel koker yellow box', 'Stromma branded', '60 pieces per 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('eb3336cb-887d-4239-a20a-4a491df5acea', 'Pretzel', 'Stromma branded', '60 pieces per 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('16a71b1a-c90e-440d-973b-a88c60ec9cf2', 'Huismix', 'Stromma branded', '60 pieces per 150g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('a766da8e-ff35-414a-addb-a3201ec52abe', 'Villa Luisa Pinot Grigio 75cl', 'DRANK CATERING', 'fles per doos 6 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('87cd8faa-651a-4338-969a-0fda178b3cd9', 'Minute Maid Appel', 'DRANK CATERING', 'per krat 24 stuks', 'catering', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('e889d7eb-7140-4f0a-9a8f-bb7ccc06701d', 'Amstel Rosé', 'PRIDE EVENT', 'per krat 24 flessen', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('8c06e30b-d3f7-4b6d-ad71-babe94794915', 'Floralba Pinot Grigio Blush Rose', 'PRIDE EVENT', 'per doos 6 flessen', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('da531ed6-3dda-4cf8-b555-9be984264420', 'Desperados 33CL', 'DRANK SHOP', 'per 12 blikjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ad50fc24-e5d9-486b-908a-c628c62e4900', 'Oud hollandse candy’s', 'Stromma branded', '150 g per 150 in a box', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('995777d4-e77e-40eb-82a1-6aa3ce42d5bb', 'Stroopwafel zakje', 'Stromma branded', 'dos 160 stuckjes a 100g', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('ecf9ba7d-63c9-4f4f-92e1-6e426f911dee', 'Stroopwafel koker yellow box', 'Stromma branded', 'dos 60', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('1b771f0b-533d-44c1-b6bd-d2e916af7532', 'Pretzel', 'Stromma branded', 'dos 120', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('2fdb981b-1981-4251-b518-fb9ef6f9c88d', 'Huismix', 'Stromma branded', 'dos 120', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;
INSERT INTO items (id, name, category, packaging_unit_description, main_category, created_at) VALUES ('71e6fd19-a499-48be-b1e2-d0dc6626cc27', 'Brand IPA 33CL', 'DRANK SHOP', 'per 12 blikjes', 'floor', NOW()) ON CONFLICT (id) DO NOTHING;

-- Insert Shop Stock

-- Insert Shop Stock

INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('998cbe29-774b-4a75-bd7f-bbf63b6d2acb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      24, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a13ea4b5-c75e-4e5a-95e7-e0c9924b9765', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'a7c39d48-b92c-427b-93dc-87a3a334d0f8', 
      0, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('45f5a6ed-19f6-42c2-a74d-e217d47d8a49', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      33, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('dafb376e-a927-4392-abf0-981a0b4e03b2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      12, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b4b909b0-cbfc-4f12-81cc-4a712843f252', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      50, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8f82fc9d-ead6-4802-9dcf-4c94f88e300f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      26, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2e28e860-b623-4ee6-b8ad-829ed1eb1ca9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      21, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1708ad28-ec69-48ca-9d93-e8d6c343f6ee', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      35, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7b674857-a15c-4e69-bbd1-423232de092a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      89, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c09a78b0-3524-4646-90a8-09f566495829', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('20ba376f-e8e4-4660-b620-6b7abc5deed9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '426730a7-c37b-4e8e-9dcc-307df00b8fa0', 
      3, 
      55, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e257f6cc-4f10-4f24-a171-13a523fa3c3b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      3, 
      8, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1c1bebd2-71a1-4d0f-90d9-a5f1b20c470e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      2, 
      53, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b9f2f6bf-3c67-4cb7-9137-f4f82f81a7fb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      2, 
      44, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fd395817-bc5f-426e-803c-f57eeaa07483', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      1, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('08ca8fcb-09be-4616-b7cf-d32be7b07305', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '703eb54d-f2e0-4c59-b62c-2a0cb6adf7fb', 
      0, 
      20, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c85bf610-c680-4a38-95c4-5eca5139fccd', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'db0b774c-5ea1-4f12-b9d4-7ac5a16e374f', 
      0, 
      50, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('22a45d8c-b709-4713-a694-dc7fdcc83860', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '3c8fe1c2-a129-4219-8130-060991c3fbe2', 
      1, 
      3, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('96496053-e570-4b8c-a164-372c2d1448dd', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'abc5f330-7711-4069-931e-196494f57a7f', 
      1, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('79fd080f-69c2-4333-9783-8317230b8be6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '31841a68-7c29-4f8c-a533-a8813d0e9886', 
      1, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d8421dee-41fe-43e2-9419-8c693f2da8d4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '5751fac6-b7e7-49b1-a5f7-60c98bf1aed1', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('350c92c2-180e-41bd-b3fa-6d474b3e93e0', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '2b0674c2-6d99-4922-a220-266c846cf858', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7e3adfff-40f9-4a9f-aa9e-5e8bda369c01', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'ec4c0b9b-a4ec-4854-8b13-ab33eccc7fae', 
      1, 
      5, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8ea54863-daf2-4345-b44f-3f0b6cd28f0b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'efb380a6-241a-4634-bb3e-bd570309446a', 
      0, 
      44, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('45565fb8-ff81-4750-95a5-c4b92e84c30d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '449dbbc4-a928-4483-abee-c7520abdfba9', 
      1, 
      70, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('345c4adc-0a76-4e05-8119-cc39af2d1f6c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'd60b2130-9793-44c0-bc6a-dc594eccbf3b', 
      0, 
      40, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c28b49ef-1df5-4e48-bc1d-ce66105f8a4a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '83544023-ac5d-49df-8709-db88c5f34e1c', 
      0, 
      50, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e2ce5d11-7431-466a-87e5-3e4e54c5d139', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '2a482631-ad4c-46c4-ac57-e9fe60a3b1d2', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('777129b5-f130-40c6-95f1-8388957ddac1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f6ff04de-3bbe-4a73-9cba-f82d1efbd915', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      3, 
      60, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('209839e2-5e98-44e6-9208-c6a691e9921b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      12, 
      35, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0fefe1e2-725e-4091-bd3b-b55b8e550c0a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      17, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('291c57f0-bee3-4e77-a338-4ea0a33fd9ce', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      3, 
      25, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7c863376-63ab-4a4b-bcbb-b98fd9b2cd7f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5926353f-0d00-495f-a15e-c79ab3ff96de', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      2, 
      9, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('73a5e400-41db-458c-a662-e796c55c6d96', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      2, 
      12, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('485f159b-d6df-497d-9cce-724b34c57c63', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1e85df4d-a066-46ce-bd53-a493525fec0e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      8, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2d3037a8-e558-4fe8-b1f6-4bae292654a8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      2, 
      5, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('108e3fcd-4ffd-4ef3-ba27-7023372d003a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '7ef2e565-acfc-4cf0-b7db-7c494b33981e', 
      0, 
      33, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bf50c44f-b81a-42b2-a034-70dc83f0eaa2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '22c68ff3-4fc4-43d4-94eb-7f37f48d6b62', 
      0, 
      29, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7537f122-2bbc-4914-a739-dfeed49750af', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'faca5bd1-c10e-4809-b203-2f1744993f93', 
      1, 
      70, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f274dee5-3248-4c18-b5b9-4dc03430956c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '0203e781-d863-402c-abfb-13203529c7b2', 
      1, 
      63, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('290c2a6b-1502-4395-83ce-a85949427bc1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      'a85d8cd3-9f3a-4c85-8e09-df26c58fc7c7', 
      1, 
      19, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c42aa883-4d7a-46d2-9924-1d1d4d154624', 
      COALESCE((SELECT id FROM shops WHERE name = 'Winkel Rijks'), '8be4a6ac-cd1e-47d0-bf4f-027bb27f55e6'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      2, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('08722767-5c19-411f-894e-5834c6a52339', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      2, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('038040cc-c46a-4471-94e7-2ad843cf25d2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c56e729e-45ca-4072-bf01-4048c4df79f1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '426730a7-c37b-4e8e-9dcc-307df00b8fa0', 
      3, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0fc8b280-0162-4135-b88d-b2c87e2e2ab6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      6, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d791791c-45c4-4983-b9d7-5523502913aa', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      4, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5965b14f-fd94-456b-bde3-4ce183d5dfee', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      4, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1bb5e162-7cc0-48dc-ad12-b537472bb7cc', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      4, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('70e9fed6-e11e-4581-a370-1c6f6a26e68d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      6, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0062ffdb-422c-4eca-9870-fd6d74820a84', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      5, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f8859906-5b1a-4fe8-a033-0f2bdd042c15', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      1, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2eac8f78-eddf-41bd-a49f-d096b054a2a7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      2, 
      2, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5ae45238-66c8-4c53-8c8e-88432085ef84', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      2, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3c06a971-c7b1-4c60-841b-7fd3ea6dc7e9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('401f2aaa-16c6-4a57-b941-4cd934ac5941', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f4fefa12-da41-4fba-8628-1ffa3d017e97', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      2, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9fb8fa93-04d3-4acb-9c3a-69ec4aae68b7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      1, 
      2, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8b76bded-afd4-4852-b729-5ab3a9e92b8a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      8, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8ffee170-bec3-4c5d-8ae1-535e1549bf53', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      7, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('27982acd-c146-4b20-a8de-281db9defc52', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      1, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1c689530-b850-4959-b548-dab2b25b3ee3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      1, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('38676258-ed10-48f0-bc7e-64cc6689ca42', 
      COALESCE((SELECT id FROM shops WHERE name = 'Ponton Rijks'), '8239c24e-92f4-4140-830c-94c014639381'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8dcdce44-2a26-442d-81de-bd329bb9ac8a', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'b3d44307-d86f-41ec-9258-2fd89869807f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8e0170e6-db10-40f8-a831-97f28620397d', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'dda14fe7-65e7-4df6-a89a-5191c6845d8f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('75c76add-6b5b-4bbe-bf20-1e2008b56c5d', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '98bce447-ec04-4711-9e03-d869b615555c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5aa4fdcd-31fd-4010-8df0-d6ef8eb02758', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'a0785b8b-ddd7-4046-b89c-c20c08530640', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('35c8f756-3d6f-48f2-bbbc-a4bd5962cb2d', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'ac6c0fa3-db11-4736-8919-653e86b4cc5c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5806b634-d6db-4b91-b259-525eaa9a76c4', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '6a186a6b-859c-4584-aa68-e5f296b1f85e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('65f923fe-4705-4950-8290-04c22af1df1d', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '8e4c8e00-03b3-4a50-9e07-31e68bcd2a3c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('dc954c18-61ef-43d0-88b7-d48f2f228eac', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '19cad202-8144-48c9-8d13-eb2d2e611c40', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('eecae979-aa62-49ed-b217-be8ac87d4376', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'bbd78e91-1c81-4ade-a48d-f39776c670b7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('443ec672-bec1-41d1-bd0a-837f7c47ff15', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '95025844-a345-4c12-a40b-291344e087ad', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ddc8dabe-09e1-462e-9cc0-9b8524fd7a83', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '6719141a-ddc0-44f3-b839-34ba6fbae05e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('69e95d27-56d1-4265-b876-3d2ba557ff2a', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '41f745e5-fd8f-407d-a566-f5054db53180', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9c425562-44cf-4e50-840f-0ef58acb039a', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'de44cc49-ad63-4848-b04f-1416cd27b14b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('886652e3-60a2-4e2d-99b8-3c6fb31966f3', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '1883ee58-52bb-41aa-96f9-63cb5aef10ee', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('05b42563-d0b3-4dd4-a11c-7328c86fe8a4', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '9792062f-1af1-4789-8c7a-476521078cd8', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0a3f2db2-233e-4142-af17-62f3f34ae50e', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'd2c10e25-1bcf-4210-8e87-cdd3f306cf65', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f0248355-e5e5-4ec0-a684-ba74b591af69', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'ea0878ef-e50c-46cf-ae3e-b28e8c621fc4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e316c259-438c-4107-9e4b-9835b10951cf', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'c3262fde-9825-4860-abe5-04790dddc241', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a8105dd6-9f81-49bc-90be-d41365ece693', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'cb043a72-82d3-4a44-b539-5175833c75b6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e8478593-33a3-471b-9c60-86086da020d1', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '033f2d59-5c6b-49bc-8385-65f1e00bd90c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('28ec89e2-44a8-4f0b-b0b7-e4350be14bf0', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '2f19f558-1d43-43c5-bd47-3572e6d6aa2f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('584105d5-f79d-4b1a-b562-2131b9a5e455', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '950bf091-cf3b-4d64-b798-f01f7e2c457d', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3036911f-1957-4581-ac67-b2bc6a303798', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('570583ae-3a23-47b6-9e00-674e73a71371', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7abe56f8-427a-4e70-965d-80ca039c6df6', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('511e0eb4-f7ce-4fbf-a796-a6a68e419d49', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e129fbb1-422e-4350-9a19-ed6e3f9c9ac8', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ffc853a1-f634-480f-a75a-b2e0d14b78e0', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c6538169-7e78-42e6-b4b0-1e7c905aa07e', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e28449fa-6be8-4491-b821-198c363d49b5', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c6dcca0e-cb75-40d9-89c7-bcab3b77b010', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0ec50808-dfef-480d-97ce-79e3e327a858', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c4ebd94d-72fc-46a3-bc39-f4c413b4e9fb', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cc4dd1da-db14-4f33-bdb5-c9381548f26f', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '553f6cbd-7ccc-4438-97e3-9be96bef5525', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1a7eabb2-1746-4ff0-bec4-cc0dfa71cdc9', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '894b60a4-a8cd-4185-9307-7f9d253a1cdf', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0dc87d59-d010-405e-a5a9-1887f5795676', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'd4facbf9-1657-466c-bbf9-b86b6362b606', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('26e22e48-6a82-4314-a354-5942545b8da0', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '26579898-f9c2-49ae-8514-6020bafa5c8e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('237021d4-e0bd-4388-9354-2031757f0e37', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '679eb1ed-cb86-464a-9a82-a0914d111f2c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('19286dd0-fc73-4493-8498-01bca2acc38e', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '971de9a5-667d-44c4-a4c0-1a86c97ed6c5', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('036dc0ae-5273-4352-ba4b-ffc4b94b9cf4', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '2c37abfb-592e-4ca9-8f7e-df1e41d7aa65', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bb3f25a0-05cd-4699-a7ef-3ee2001944c4', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '4eda1a7c-0517-456d-855f-d22bb2736278', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('aa603800-2199-46f2-8879-3547c23908df', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '44e94a0d-fd32-4824-8993-e2a5dc0d0f87', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('06abb9f0-7147-43c1-9176-220d9d7a347e', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'ab16c8fa-d0ae-4972-a2a3-e8e76370057a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('288b910e-ab7f-4651-81e9-5c8dcc2a0285', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '5903ef07-d99b-41a6-bd00-c48ad5d93f5a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2f5605f7-6c31-42f7-9d55-def5abc14af4', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '5fb6e52d-af6f-497e-883d-6d5a9f6b4c33', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c015939f-8550-4775-9fd3-c854dd65ea58', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      'c4c27088-b76e-4fdd-8487-e5d4ed92da39', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6b32b837-23d3-4ae1-a918-537094e7f78d', 
      COALESCE((SELECT id FROM shops WHERE name = 'ARK Rijks'), 'fceef697-1ef9-49d3-9308-023ba61c2cbe'), 
      '85398b8c-cf7c-4b88-bea1-3fbc558e9ac1', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d6e1efc5-a7bd-4f8e-92a6-002b61089332', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d6371722-3e6f-40d1-ada1-a28883719f55', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'a1c0afae-aa17-4ddf-b752-17b0d1403f30', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a889df27-6931-42c5-8e51-21b52f41070e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f686ac58-4a78-4dfe-a117-648c235baeba', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('16eb71d9-61be-4b37-be1f-1647d7697b37', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5fd23b7a-b527-4cd2-9955-b9166a9eace2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5fe32992-350c-44e4-bbcf-ecc2828e8eb4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a8e86c87-f106-4a72-b202-308a0b1e1170', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0f00c7fb-ae14-4403-8324-287b7f3fc8c9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('aa86c4fc-9c73-47d4-9b5b-f7b2905b3c9a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7fd8ad00-068d-431e-b64f-1dda61bad836', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '426730a7-c37b-4e8e-9dcc-307df00b8fa0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fcc2d661-d8a5-438d-90a0-21b667e8240b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fa1ee40d-5831-4d02-8b11-32633fbf1259', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('31104f78-9d60-4f33-b666-c27fd16aaae4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('087c938a-4c3e-4942-a4e5-342ff9f83539', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e34461c9-6dbb-4767-b72a-5c6ad552b25a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0c2e6b25-72b2-4ce5-8f53-ca0b57614298', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('583297b7-249d-4b44-adf0-d5ff8b3d087f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bfde251f-b22c-45e3-a5c2-b38d6c669b2d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('58a26d7a-918f-4226-aefb-12d99ef0b54b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fc980d9d-0740-4e99-a97e-5f60770becc8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('85b84bc8-5ffd-4d7e-a320-4ef4246f7b7c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('11e5a535-4e38-4abb-8b86-0115c2df2f4d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3898dd38-0f03-4c0e-879a-7a17407fdd91', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c5d81590-4cba-41c2-89ed-a89dbc730892', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6fd76915-1949-4275-96a5-5cc65c78b584', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('54bb55fc-d784-42a1-b41a-5da57f1594b3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('65d29e1a-f3ae-4b36-bddc-37dedc875d45', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7badf61b-d42c-4f93-9f2e-604ccfdb03d8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9f1af8fe-c3d1-42d1-886e-e4d41d8663dc', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('29123032-6eda-4edd-b61e-6fefd92b48e8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4a513363-459e-4e26-85c4-ef85f42ce9a4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('96371082-f25f-4dd5-bec2-09d2a83d249e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('62c81bab-c895-4dca-94f0-5e33fbb92657', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3e255177-22c2-4027-ba75-92fd19d02167', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f80de55a-ab86-4234-9621-797b1398d0eb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f65930b8-276f-4bb7-8617-b4c4f2b21700', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a39dffff-d03c-48fa-9f79-75f7f1877b1e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6d0ffeae-600f-4ab3-b94c-b619cc39e200', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a7b36a18-e5e7-4cbf-b4df-972192d68d4d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('88c1a45d-38a5-496f-aef6-8580a3703ec7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'cbbee67d-3565-4917-aff4-3741bb0cde37', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('aea05fac-df47-4a1c-a934-80253e6b539f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'a095faa5-e77d-4fcc-8c76-524cc67b1b68', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fe12241f-e554-4f04-976a-ef5f52f0cca1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '9ccdaefc-a0de-4882-a058-6508b7b46a91', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6f0f6f4c-84ba-4dd3-b0d5-715a2572dfbe', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      'eb3336cb-887d-4239-a20a-4a491df5acea', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4ea5f3c3-5457-4501-8b04-479877e88824', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '16a71b1a-c90e-440d-973b-a88c60ec9cf2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c91134ce-41d3-4551-ba52-4153d58ea707', 
      COALESCE((SELECT id FROM shops WHERE name = 'Leidse'), '0189fb6a-7228-4bec-8baf-3d274c3dcc17'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4795f5f0-062e-4b82-b864-6a6de82846dd', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'b3d44307-d86f-41ec-9258-2fd89869807f', 
      8, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('213bc23b-1b5f-46ed-acc2-9ade805965fe', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'dda14fe7-65e7-4df6-a89a-5191c6845d8f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2077e6e4-3116-4ff3-a8f3-735170ef5050', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '98bce447-ec04-4711-9e03-d869b615555c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0fb61dea-3dce-4852-a6bd-c040d55bea4d', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'a0785b8b-ddd7-4046-b89c-c20c08530640', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bb242321-bf2d-468b-83f0-bf53a22c6972', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'ac6c0fa3-db11-4736-8919-653e86b4cc5c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('32bc92b9-1932-4d8f-87bd-2a1c63b0153d', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '6a186a6b-859c-4584-aa68-e5f296b1f85e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1eca0e60-ab3e-45f2-9f3e-aee530d84ffc', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '8e4c8e00-03b3-4a50-9e07-31e68bcd2a3c', 
      2, 
      3, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3060e4e1-37b5-4c47-bf99-4680c48876c9', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '19cad202-8144-48c9-8d13-eb2d2e611c40', 
      4, 
      2, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e977faa3-288c-43b1-aa24-bd2ff64fa3a1', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'bbd78e91-1c81-4ade-a48d-f39776c670b7', 
      1, 
      2, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8ef9bd04-88db-40c5-80ea-1e29c0dca1a8', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'a766da8e-ff35-414a-addb-a3201ec52abe', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('31c9564b-4572-49e6-a233-e60eb9a189c2', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '95025844-a345-4c12-a40b-291344e087ad', 
      11, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c9a768f8-0aff-45d5-9267-0bf2e79ed4d4', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '6719141a-ddc0-44f3-b839-34ba6fbae05e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6343cf19-99cc-4676-8d33-79c4c438172d', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '87cd8faa-651a-4338-969a-0fda178b3cd9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4af300a0-90b6-4588-ad4d-56420d42a4d9', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '41f745e5-fd8f-407d-a566-f5054db53180', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cb999c5f-1d28-4e38-8f3d-973fa3edf0c4', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'de44cc49-ad63-4848-b04f-1416cd27b14b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bf7dad43-91de-4358-abd1-c77bd8d193d4', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '1883ee58-52bb-41aa-96f9-63cb5aef10ee', 
      0, 
      60, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4ce1fb9a-5f98-4209-92af-a3c90268716a', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '9792062f-1af1-4789-8c7a-476521078cd8', 
      0, 
      36, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bb91be92-c800-4b89-8aab-7f09c40ec718', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'd2c10e25-1bcf-4210-8e87-cdd3f306cf65', 
      0, 
      41, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bf9eb4d5-14ba-4ff3-bf0d-a4fa3982ea1b', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'ea0878ef-e50c-46cf-ae3e-b28e8c621fc4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e5fc7d77-0385-40ae-9847-f3ae9f17a093', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'c3262fde-9825-4860-abe5-04790dddc241', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4ded567d-3c47-4d89-a6ad-e908a9b5b6ab', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'cb043a72-82d3-4a44-b539-5175833c75b6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('170618a4-473c-471b-a9ce-f69acc2c420f', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '033f2d59-5c6b-49bc-8385-65f1e00bd90c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ec3ac320-393f-423e-bcac-cdca77f217c5', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '2f19f558-1d43-43c5-bd47-3572e6d6aa2f', 
      12, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c859a193-2311-4ed1-b16e-0ef2e633ef98', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '950bf091-cf3b-4d64-b798-f01f7e2c457d', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a1fc8b3e-96c0-4cab-9c16-52291aed913f', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '553f6cbd-7ccc-4438-97e3-9be96bef5525', 
      0, 
      4, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('692549c0-6bbe-4736-b05f-3ab7e73f1a57', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '894b60a4-a8cd-4185-9307-7f9d253a1cdf', 
      0, 
      2, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4efd9e38-5979-4b7c-b23b-57516e3d0fac', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'd4facbf9-1657-466c-bbf9-b86b6362b606', 
      0, 
      1, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3a7ec3e6-bec7-428a-9d08-d69124c07819', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '26579898-f9c2-49ae-8514-6020bafa5c8e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7b146593-8fc2-43a3-bfcf-5b370b57a5e1', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '679eb1ed-cb86-464a-9a82-a0914d111f2c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4f9a0caa-f424-42bd-9c69-b56ceffaf6b0', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '971de9a5-667d-44c4-a4c0-1a86c97ed6c5', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('15a6a63f-7288-456e-8003-baccdbf8c079', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '2c37abfb-592e-4ca9-8f7e-df1e41d7aa65', 
      0, 
      1, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d2fbc21c-cd78-475f-976a-821a71c813ed', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '4eda1a7c-0517-456d-855f-d22bb2736278', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('62942378-3ad4-4fa3-b9c7-c3d5f5cdb234', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '44e94a0d-fd32-4824-8993-e2a5dc0d0f87', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('27c4c4ad-c339-4eee-ae78-570a966dc451', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'ab16c8fa-d0ae-4972-a2a3-e8e76370057a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('59bf3e96-7023-4c79-b874-a0d4669e0b7c', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '5903ef07-d99b-41a6-bd00-c48ad5d93f5a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('687f93d6-078a-4035-8a96-cbe2bfcc9fec', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '5fb6e52d-af6f-497e-883d-6d5a9f6b4c33', 
      2, 
      4, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('dea0c161-c63d-41e9-85c8-fbdd056efcfc', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'c4c27088-b76e-4fdd-8487-e5d4ed92da39', 
      2, 
      4, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('97038bb5-97f6-44b3-b19b-0fa010546970', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '85398b8c-cf7c-4b88-bea1-3fbc558e9ac1', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('df8ec426-79d6-4958-8a2a-c6ecfbed4254', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d6d84837-34cd-4d1a-a832-a0a62da52a29', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      'e889d7eb-7140-4f0a-9a8f-bb7ccc06701d', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('244b5093-15d5-45b6-b8e4-c4bf70cff2a9', 
      COALESCE((SELECT id FROM shops WHERE name = 'CS Oost'), '8cd447eb-ca21-4ba1-8b03-f308b211f8eb'), 
      '8c06e30b-d3f7-4b6d-ad71-babe94794915', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c49a3ae5-a341-4b27-bef8-0e010bd41b7b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      34, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f13402ba-ca68-4429-85e5-546d17fbbbec', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('af449807-fdb9-4b15-9017-8736329decd0', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'da531ed6-3dda-4cf8-b555-9be984264420', 
      0, 
      32, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b087ae2f-8fc6-4886-821d-06158953f6e5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      1, 
      12, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('398d93dc-6f44-46b2-8564-54e7fed8e2bb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      1, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9658f87d-a13f-41c4-9a36-dcb4dc844855', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      0, 
      24, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0ae86df8-26b0-41ec-87ba-52165cad8fae', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      3, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ebf8fc46-56fd-4812-a198-ec36256cde59', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      0, 
      92, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('941b6cb6-01fb-4c21-8547-a7d9d0e06baf', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      3, 
      40, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8cdfa7f7-3596-4ce2-9320-bb7963b526a2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      0, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ef9b51c6-2fb9-4f2f-b8d5-d62f2156aed7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      0, 
      16, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3afb6ba2-c87c-4223-96d8-2f9d0b2b1661', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      0, 
      9, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('15fa91b5-ad01-4dbd-a1b1-38cb1662b213', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('64a57c86-7904-47d8-9890-c22dbe581785', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4ae53d98-1690-4630-b188-4b88d3114fa6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      2, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('94a25e45-aa07-4cf6-9b79-5793b73a3b95', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      0, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e27e035d-f938-4fe9-acb7-5606406bfbff', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      1, 
      22, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('42342a4b-1666-48a8-9c98-87123a8d1946', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      1, 
      25, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('eb02e6db-f25e-4ea3-aa53-02cbba1196b2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1bf47f7d-4f8d-42a8-9db1-d7220500e629', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      12, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d376ff0d-b2c1-4eae-91e7-c49c82874a47', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5b81bde0-a530-41df-87f2-002c2ea57b24', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      4, 
      19, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('15d4b87e-fff0-459b-9c89-8856d061a348', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      8, 
      30, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('de94d9ec-4c46-40e6-8367-f684eb8a267b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      1, 
      17, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a24cbcef-ef88-4350-8fdc-67f54d499dd8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c970f0fb-e20c-4d59-bef8-5651a1be5b97', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bd0d7cef-4f0f-47bf-8c50-d40a18c1b7c7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      1, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0e37ee32-c671-4f42-81d2-83e38ed1befd', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      1, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('919907f8-d267-48f1-a02c-ca74e4b4466a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      1, 
      14, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8d959756-be34-426c-a356-0d061f58c952', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      1, 
      5, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5ca1bb1a-ad54-4b96-8de1-0b73187c4e2b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      1, 
      12, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4d342fcd-605b-44be-916f-a0f425e8b2c4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2f850dd7-9852-4668-91f3-8a5c5144da2c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d7ff03a4-e103-4994-9e06-795a77aef50b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'a1c0afae-aa17-4ddf-b752-17b0d1403f30', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2e534017-508a-4a3d-acc3-405c4e34d4fe', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0007c404-f64b-4669-b7f2-996af185d996', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3c16d6ee-23ba-480d-a750-ff8737d200f6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8ace4acf-b46f-4fdf-ad1b-80c7e68b7659', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('17fcac26-458c-4844-8040-10689708c011', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4cb562a0-43c7-4645-ac5f-5d5ab3bf2d2f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3e07e8c1-d084-4227-9afa-94316bd3ff39', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'cbbee67d-3565-4917-aff4-3741bb0cde37', 
      0, 
      45, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a53dd118-5a35-4351-ba99-3b5024f42fdf', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'a095faa5-e77d-4fcc-8c76-524cc67b1b68', 
      0, 
      54, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ea032cca-c839-48f0-b344-a0b0565dfcf7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '9ccdaefc-a0de-4882-a058-6508b7b46a91', 
      0, 
      45, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ec85b7ba-3a69-4a33-8c47-52990f3edba3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      'eb3336cb-887d-4239-a20a-4a491df5acea', 
      0, 
      51, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c3505e3c-f281-44a3-815e-d36672c3d697', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '16a71b1a-c90e-440d-973b-a88c60ec9cf2', 
      0, 
      50, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8bfbf08a-62bc-4dea-b11f-710481fb6a49', 
      COALESCE((SELECT id FROM shops WHERE name = 'Bridge'), 'e06f3d74-8099-4d3f-9f67-f858fe5b689c'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('98667827-eb46-4b75-9cf9-2e9db9696923', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      1, 
      35, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('62b14f08-bd37-49de-ab03-e25e049f614e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'a7c39d48-b92c-427b-93dc-87a3a334d0f8', 
      0, 
      34, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2c26d273-9673-4604-8ae9-46b3a8cfd2f5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      41, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2dc25233-18a0-4fa2-b640-eb3f96ba7393', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6f64d3d2-048a-4fc1-9316-22c4391b5851', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      32, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1c69f2f8-e654-4fc7-a141-d1026230a528', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      35, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('071474df-fa77-4be3-a2cf-a82d482b0c50', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      9, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fe089479-b854-4139-bf12-6c7ed41460f1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      31, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0488a551-3245-4f56-9be0-6e8d1d666491', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      35, 
      96, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('07d1dba6-c3fb-4270-bca1-7ea8bba3d4a6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      2, 
      21, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1c2f4339-1811-46ec-ba23-8c608a1a05ca', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '426730a7-c37b-4e8e-9dcc-307df00b8fa0', 
      2, 
      73, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e0d4706a-f35a-4f93-a62f-478862d2adc0', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      13, 
      64, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('27fc9485-4fda-4658-aeed-5e2369351ce5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      17, 
      55, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ac97468c-e7e7-4ad9-87b0-8940bb6ba9f6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      7, 
      41, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('18e25be4-e5fb-4370-80a7-c1c173cf298a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      2, 
      30, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1eba0b79-8601-4472-b3c8-6e8b660b29a8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      51, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('13f4d2bc-364e-479b-9a33-5e48a7fd7121', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      48, 
      93, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e48bc4cf-668c-454a-8337-2f7dae0ede9a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      3, 
      21, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('57629c2c-3033-43b5-853f-0d7a9db8501d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      4, 
      26, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('33cfaf83-74fb-445b-9b38-3efede0dfa0b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      4, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b0d0e920-7699-420f-99ca-c9364fec9a02', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cea83f3f-654c-4bcd-9fd2-011414e4c880', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0ca64c7e-f410-4138-a40c-eaffe4db353d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      2, 
      30, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('415023c7-06a1-4b82-a932-7baac6032b8e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      8, 
      70, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('35881efa-dd3a-4f35-bda5-a3c6458911b0', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      17, 
      79, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3ceac62e-9678-475a-98b2-9ec74c9e6a91', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      7, 
      48, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('038aecb9-a9eb-483e-bd8d-f3a1e91c1133', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      6, 
      35, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('74cf0267-9875-49b1-9300-8f50c727dfc1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      30, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f78ee726-3993-48a7-9742-22414eb29902', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bcfe705f-f369-4acc-8b53-a54d31f3231f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      14, 
      62, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a6cea23c-315a-4aa5-b80f-fc4746c2a8fc', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      8, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0aabfa7f-e04c-4fc1-ac32-568a7cdf05ba', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      1, 
      20, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9d984b0f-ae9d-4705-9f81-65f0f83e65de', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      1, 
      35, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a84486ef-e26f-41ff-9cfc-f765cf89dc93', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      2, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('078f5402-7e0f-47b1-ba05-fe40784f173e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      19, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7763e3e7-f158-4260-b455-cd5c40ec2b3d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      45, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4ef7f53b-bffd-4ac9-b09e-b4b572adc484', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      7, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('61a1b3c5-702a-4f14-a5df-b3c0e0e6e67e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      31, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('da16b180-b397-44a0-bde6-5d37c3f83ba8', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      1, 
      38, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('75450b61-b2e1-4264-8b4b-9317a45cdecb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f4220100-4666-443e-800c-5bd0860ddcab', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'ad50fc24-e5d9-486b-908a-c628c62e4900', 
      0, 
      66, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('21223534-250f-4b25-ae2c-fe8035467746', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '995777d4-e77e-40eb-82a1-6aa3ce42d5bb', 
      0, 
      21, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('64e65369-459a-4956-b55e-c9920b7ae66b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      'ecf9ba7d-63c9-4f4f-92e1-6e426f911dee', 
      1, 
      79, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0f0a85d5-6e4b-4e99-a457-ccce92f7df6a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '1b771f0b-533d-44c1-b6bd-d2e916af7532', 
      0, 
      65, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('57ca6dcc-9f40-4d25-9d54-6dc3ec1edeb1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '2fdb981b-1981-4251-b518-fb9ef6f9c88d', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6f214e4c-44e2-4e7a-841a-9e34597c9a5a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 5'), '5825609a-fb44-442b-9d24-a40136a057b6'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      11, 
      98, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d2bbf111-9c54-42b0-af1c-f412e1296998', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('189e0746-abcb-40d0-b399-70a2611b006a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      17, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bd105b11-922b-40b3-a336-da40fdc65b00', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      11, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b4d04e07-75f4-4c1a-8d94-910799cc0ff6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      17, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6d0f0f41-3f83-4761-813b-d7bcd83c5076', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      21, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d21a894b-10bd-4670-8dff-dd0cd30e8ffe', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      20, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('72bc4942-8f6a-4060-bf6d-5f6eaeb116b1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      14, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('69c36042-db46-4d9b-bd04-3af74eaad083', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      66, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fd78a633-8923-4f1e-be5d-8cb3227fec4b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('923a70fc-3b28-4728-9328-b1f14eda99f1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'da531ed6-3dda-4cf8-b555-9be984264420', 
      0, 
      110, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0c4d61e8-ec84-4a20-929b-53d6e17531d9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      0, 
      24, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0bf54b70-df46-48a6-87e0-fff8a0ccc0fc', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      0, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('51d78709-3e7a-4d0d-ab86-001aa2964d0a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      0, 
      21, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7c06925f-c717-4ff7-a406-f5e7211f0ca5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      0, 
      14, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('649c600c-47d6-43a9-a86f-1baa249576c9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      0, 
      28, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7bb1918e-df02-4ff5-8913-cc4bcb1fb1b4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      0, 
      22, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4980c543-eca9-4054-8748-1a087d76de05', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('22eafbf7-ad65-42af-8528-e2bc0c238cb4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      0, 
      6, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('82a4f90e-2f8a-43e0-b911-adf1aee4a709', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bc7b6149-75b1-4639-b01d-7f0f77fe820b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6044589e-f1cd-4a0e-840f-8f64fb04b025', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('528d79af-e918-47e8-bdec-5b22fefcab0b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('706e5bcc-b448-40ac-8018-f98fb5d8f8a3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a2d465ad-b43a-4ca9-942e-80bd12c2e688', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      0, 
      22, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('58c36d03-7f9e-42ca-9360-0c6e9a6e6f6c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      0, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c6c3435b-f047-47b9-bfea-ddb0a9a65102', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      0, 
      4, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3ebc63e7-b042-49dd-a67d-4723845d9afb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      4, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1c953c62-02c0-4526-bbf4-c17ff7b1a26c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('46fba077-df8c-4736-a2d1-784ed8c9b539', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      0, 
      45, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3fdb3215-3e84-440b-9a61-51e1ca8faaac', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      0, 
      44, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4dd8264c-e8b0-4381-ad2c-4accd573086f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('73b582ab-fb37-47bf-a8df-3b0696d738f7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cc2d39d3-43d9-448c-9746-00c07bb50276', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('462b7b74-282f-4223-845a-e410d8fba92f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      8, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('523334f4-5f52-4083-a021-044e13943cf3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      24, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('122f638c-6160-4eb2-8cf4-ba01ded91bdc', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a61292cd-6a46-4dd0-9fe3-e5628c0e12f9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      8, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('65fdf028-05e9-42c8-9746-c2b31549ed6c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('78ea2a4f-fc31-4217-94a1-b6a115856bc3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('32a91e5d-a692-4226-9a7a-ea1c06a57b0e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'cbbee67d-3565-4917-aff4-3741bb0cde37', 
      0, 
      22, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7ea4cbc8-49e2-411a-93c7-0ba1a0337eab', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'a095faa5-e77d-4fcc-8c76-524cc67b1b68', 
      0, 
      25, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a203682e-4b30-48b5-b475-dcba8fbb5835', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '9ccdaefc-a0de-4882-a058-6508b7b46a91', 
      0, 
      45, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5c4e2d40-2864-48b0-940c-826eb8519031', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      'eb3336cb-887d-4239-a20a-4a491df5acea', 
      0, 
      14, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c349a894-db45-4387-9650-4addb0691df5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '16a71b1a-c90e-440d-973b-a88c60ec9cf2', 
      0, 
      11, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a7e1368a-33c6-4c33-b63a-1efbb8bcabe2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 6'), 'ce8b3886-03b8-4922-98e1-b3e974f57082'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      0, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f8dce797-6ccb-45d3-9879-c22339aef4fc', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('48458211-d261-4993-9405-d337711fc1ea', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('93191134-cf67-41ff-bde0-871c91414996', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '71e6fd19-a499-48be-b1e2-d0dc6626cc27', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('27ec13c7-0744-4722-bb65-253686bf61f7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8a147d91-0680-4c6f-964e-7f342c23286b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3a0dddad-40b5-478e-9dd9-eb0511eab632', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f808c963-5f86-4b46-b71e-0ee9b7fab47d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8ebc49f9-34a4-4433-b787-534f0b11222d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      0, 
      34, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('72427eb2-65a3-4387-942d-cfe0ee45426e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      0, 
      40, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3f0e2560-c254-482c-ad11-3f1611231431', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      0, 
      7, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('c49d5cc9-f554-4508-aa53-183f36432f4f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      0, 
      7, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('de50a16e-b62b-40c0-a5de-2ce5e4fbf2d1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      0, 
      8, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6c19cf04-772c-4a38-8395-ace42b3f36e9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ab86db27-6a24-4011-b113-673c28ceacbb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2e74e5f7-ece7-4296-b848-f493708aeb05', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      0, 
      28, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1f04f96b-05f5-490b-935d-92b09ff24ea1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      0, 
      38, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7fb4dc46-d80a-4901-bcdc-db85b012e058', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      0, 
      18, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('710f122a-f9ce-4f8a-b1e7-f2d0fa974580', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      0, 
      24, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('57418216-69ee-48bf-b15f-2f511598b6ce', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      0, 
      7, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cd10fd29-9fe9-403c-b86f-009e05452cc4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      5, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a530df3e-263b-4a5e-8e80-6bd5fe4b075d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9402c743-eb7e-4641-a685-ca9e78d61f2f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      0, 
      30, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0991783b-b757-4c7e-a6d2-8c8e33517233', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      0, 
      19, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('33366743-e1b6-473d-aa90-53e9fca66de4', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b184d395-a139-429d-8c97-12e50e946ad0', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('698f5343-55e0-44c9-aa5e-bb7b71fbaeee', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('449ae30f-87a8-4353-b9c5-a9d0dca993d0', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('47e0d153-f21d-4864-9509-7620a2a211e6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d4173578-117d-4392-8f7a-916f9c31e234', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d11dbbbb-020f-4d6c-a2d1-d7901d3e3976', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('43c1615d-335b-4812-b20c-c1803a761752', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5d7bde17-18ad-4ea9-b781-e2b9c4e0cc97', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('18c7509c-5a5f-4658-9bf8-d57500b833d5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      13, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('77e1398d-ebeb-41b8-b498-e9979588e12f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'a1c0afae-aa17-4ddf-b752-17b0d1403f30', 
      0, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ac94472c-cb7f-442c-8dd4-c76aa1415dbb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      2, 
      15, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6da72aa0-4143-4724-93e2-b387ff718217', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      2, 
      10, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('afa5d630-2dd8-409a-b001-d17a630ec107', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      1, 
      19, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('982e96fe-2038-4ea3-9da3-2d5280842556', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      1, 
      20, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('18b49ed3-d8db-4800-8344-21ce8af3e369', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      2, 
      19, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('35620554-2e12-48d9-8e12-e5c5a638585c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      1, 
      16, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('91b149f9-cac9-4538-9429-987c13e62867', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'cbbee67d-3565-4917-aff4-3741bb0cde37', 
      0, 
      8, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8e5a1282-7ed0-45a8-bb41-4255c29d7472', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'a095faa5-e77d-4fcc-8c76-524cc67b1b68', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('94a56997-41a5-48cc-b593-4d3cfc8c7816', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '9ccdaefc-a0de-4882-a058-6508b7b46a91', 
      0, 
      20, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d1a5b497-8f6b-4925-8c36-80341b093232', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      'eb3336cb-887d-4239-a20a-4a491df5acea', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b825cd7a-9f90-4e73-b6c4-157b5610c66a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '16a71b1a-c90e-440d-973b-a88c60ec9cf2', 
      0, 
      9, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f73856c6-2cdc-4839-947d-c709e23bbc42', 
      COALESCE((SELECT id FROM shops WHERE name = 'Vlaggenwinkel'), 'c410a3da-a83a-430a-9aa9-7c13a26f7345'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0bf9bb43-ae06-4271-9044-e2f012b08964', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9786ba5e-f6b2-4e96-a81a-37b08bc73913', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'a1c0afae-aa17-4ddf-b752-17b0d1403f30', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('20bde547-6dfe-4c66-8c5e-d38137bc4178', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('99c9eedf-4683-439e-ac16-56b17918e8af', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6c3c80a9-48cc-4aa5-b5bb-f5c8fec086dd', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f3b2af66-7e2d-4135-ba38-8f8f26d73b9b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cc6e9f40-239a-458f-9bb6-4a31fc092abb', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9cd26e8d-0aa8-444c-95ab-f61ebafb6478', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('48091ed4-21d0-4788-ad60-9ca2b685db35', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('209d0156-6974-4e97-ad33-5f9bc09c0285', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9b42cce9-dec9-4c3a-8036-a27dbbb0b290', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '426730a7-c37b-4e8e-9dcc-307df00b8fa0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('235ce01c-0b11-462c-9e4b-65ecff7e38b7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d92db59e-2da7-4510-9ba5-a827af236fd2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4b82b5b0-3764-4fcb-abe5-5d68cc0f865e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9d98940d-7bd8-428e-8b32-f228d956900f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ef960f25-47c6-4c83-839a-1f4128321e09', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('736a10ff-fdfe-47f1-9d10-c7e33f013557', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9e774a66-8485-48f9-a80f-23888cc1df43', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a914c055-2c03-4735-838c-b139c95f6b90', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d6e8a64a-1f7e-45d9-9170-1e7f58a7b4cf', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f10bccd8-df5e-490b-bc89-9a710f095712', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('21b6c27b-0325-448e-86c7-cee9b67be7b9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('42e6ae7f-321e-4388-b5a3-a08debc9e4c1', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cd107534-bafd-48e0-86f9-360eff1bcf7a', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('068c3ba0-ae99-41bb-9332-12efec51b637', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8bff8191-15b2-47eb-b942-4d59ab1c4f6c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('5d84aceb-9042-4dd6-ad43-aaf95af2d547', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fa3453cd-9f62-4f9a-a0c3-46691368adf7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('32668ab0-d1b0-4002-9524-86bf87645944', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a889dd73-504f-4650-842c-ae55940a5df3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('67c4f772-28ee-4b19-9bd6-9182ab7514f9', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9254c511-133e-485f-b739-3ed5a86f38ac', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d860e0e6-dcd8-4f3d-8ea3-1a6e41fc4d6f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b12656c6-69bd-468a-880b-29192d15b3cd', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('bd485dfe-0e03-4c00-8f72-81be680b8d0b', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b110de20-80d1-4881-a350-b856faf9e3b5', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('835fc65c-e6f9-4114-b82a-924db45299a7', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('66e4e702-0941-4fe3-a18c-a3c80fb3524c', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a6d141c0-d37d-43f3-91cb-28e98d15847d', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('998930d2-584c-49ef-b0c8-7f0c9bab42c2', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e9873c60-ceac-4160-8399-12ee34419f87', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'cbbee67d-3565-4917-aff4-3741bb0cde37', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6df1311f-26eb-489c-bae4-81a29df2a206', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'a095faa5-e77d-4fcc-8c76-524cc67b1b68', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e6ef4447-ac84-4a33-b93a-e8d3227d7b9e', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '9ccdaefc-a0de-4882-a058-6508b7b46a91', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9cd2949a-88bd-4eb3-ba0a-8399a104a33f', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      'eb3336cb-887d-4239-a20a-4a491df5acea', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0e321caa-de29-4607-8d1a-14d72526a1a6', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '16a71b1a-c90e-440d-973b-a88c60ec9cf2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7c59d876-abdb-408c-b1af-f153728b60b3', 
      COALESCE((SELECT id FROM shops WHERE name = 'Damrak 4'), '3b9f0f1d-bca1-449e-9e3e-97ea70956d40'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8a26a284-a2c3-4717-8255-f3d2a96a60d2', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '5cacea9f-000a-4a2b-9449-da7976ec9a55', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9306808b-f8c7-44c7-87c4-45648077f28a', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'a1c0afae-aa17-4ddf-b752-17b0d1403f30', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('0c263ccd-2470-4273-9328-9c4c7717ef19', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'e5e80b55-289d-46a7-b2bd-a3b1e7a4b8ae', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('3cf18031-ce39-426a-abe0-961c8ed0ec36', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'cee6a9db-3ef6-40ec-a39d-2dc0f5226116', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('2809f576-f6df-4311-8974-7bf139c70f0b', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '64aaa512-b6b8-4b01-af5d-c3830c9f6ec4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ae4fb3ca-1b4a-4782-8e86-1407a3453f4b', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '3f7b47b9-0f5a-4fb0-98f5-38f5c442f764', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('01d47841-f226-4ca1-a8e4-29e9c92b3d50', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '135cf50b-905c-4a56-8d09-8fa3f9937ad0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('1806c1f9-31c8-4a07-a4e4-55e58a2f6341', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '457024a9-9985-4aaa-bed4-e6f9167e4d16', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('eaaf9689-67e0-4069-9256-a3278f8992bc', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'f48cf38a-10ed-44d2-9422-dc0df82f572f', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('15e741ce-39fb-4f90-b7a3-c50de459c9c7', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '6677c335-23d4-4681-b8c0-a099313e56eb', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ac63565b-c6e2-400a-91d7-30cc08f641f5', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '426730a7-c37b-4e8e-9dcc-307df00b8fa0', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('b253db3a-bea6-4e95-9031-d70054810c55', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'a1c46ba3-b912-46b1-9162-ab268e738f00', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('4c5a2223-c431-47a2-ba61-6dcb13f57fbe', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '7547ba73-a094-4355-ac54-54e3e1afca20', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('26f9edbb-334e-4dd0-872a-bc90f171804f', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '081ce98e-859a-424a-9d73-17eb89b16091', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6866987c-5153-436c-874a-a72518e2aa27', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '6b83fa1b-55dc-4a0c-99c3-5c4753f43b80', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fbe2268b-fc69-456e-b591-bf7365ec042a', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'a04fd71c-f4a6-4ef8-8de9-448e917099d4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('134f780a-03b5-45fa-bae3-8b67d894b798', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '63610cb9-1ba5-4b69-b3ed-60bae096222b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('76946c43-1396-4e57-b3c6-5ce9c8ccaa70', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '92b97db6-0312-4877-a610-7fb9a7f42a5c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('6f7574c8-9b99-4c07-ae6c-2def70ff0413', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'befdf5d1-2b1a-4c68-9f4c-e0e9d9c7c38e', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('745f4054-7608-4d8e-961f-2a4afe1d75d2', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '0ecb7dd9-00e9-4efe-ab0f-28500bbb32d2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('88e2ee5c-6040-4cfe-9b62-e92bf4750d45', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '02b449c0-9f57-4ea4-ae0d-03d93ec0a4f7', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('733f372a-7960-4a49-b148-d8d8030f44d3', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '64c9449b-9eb2-4522-a241-29ee77afdfff', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('09d54df9-bfde-481b-bf23-30206acb5a4f', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'fb2f6eeb-d17b-45aa-b369-7b3861f6eea4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('e9362bf5-7a42-4046-bc4d-80468626c2a3', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '6033ecc2-2b28-4e6a-8dff-f149d4804d5b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fa6d4baa-2896-429c-b1a5-f5b5624ecef6', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '7d2a9798-a303-461e-8487-be1fe9d66672', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('db284267-4767-40f3-ab24-f29fe8ffe58f', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'b776cec8-ab31-48e7-9192-e7ce3a03a106', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('eb194780-cbca-4e99-b30d-ec9a9456b554', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '786ac8a5-6797-461e-8480-5e7f6bccdc59', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('d48cde4d-4f48-4f60-a47c-8cf59c8f28c5', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '380eb32b-e93d-4a94-a97e-4e1105559fe4', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('9fa517b4-c470-47a3-a54c-33e7a27a3276', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'e3b460f3-7b85-46c4-9fb5-46a99f17128b', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('aa37b93f-ad5b-48bd-af0b-3d22e3f559d6', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'ab7b449e-1386-47d8-a46d-ada9f8415012', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('eeecb677-bbc0-4916-876e-dd3e3c0a051e', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '2b0d382f-1fc5-4fb7-a833-07090409396a', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('fa8808f0-d42e-4cc9-ab96-f256f46f6689', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '09465f93-182f-4bdc-8130-02a19206d711', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('20a830a8-5abc-44a1-8fc7-70c9bc967148', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '0046c08a-02d8-4221-8ef3-5664b6820b7c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('db368bc0-1846-4645-820a-4697f5469802', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '0a47c79c-8435-457d-9d8d-389c1f780768', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('630c8962-aca9-4b0e-a033-6c3a8b9bdb54', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'a7ae210d-3751-4598-9458-882191214b2c', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('22d43b75-faa1-4eb5-bdc1-ce4c8eade25e', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '46b74937-eb06-4119-9abb-17221e73dc93', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cc8119b0-5ec6-411c-b4c4-8af3dc43604f', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '52d4fe38-2b2d-41bf-932b-2761dc6639c9', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('65f304ad-5e7c-45a4-90ab-1854f8155379', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '8cbf44c9-12d5-479e-9174-145c28810778', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f667b856-de9a-4c03-a49b-f0df7caa0272', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '36a7f7b7-53b9-4913-9dc6-372c2d2668dc', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('ccbe4d96-9181-4761-9a40-7e176d430da4', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '8b9258ba-dd8d-41fc-bc0f-2aa9e1113d08', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('8f240b07-e8c2-478e-9212-8f5a0e0e3602', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'cbbee67d-3565-4917-aff4-3741bb0cde37', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('f4b56f06-7b73-4852-9751-f89474cf0275', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'a095faa5-e77d-4fcc-8c76-524cc67b1b68', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('cb35d93f-4690-4fda-8db3-d6d73cb2963c', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '9ccdaefc-a0de-4882-a058-6508b7b46a91', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('7a42a235-ff96-4e55-b048-d8057eb7fa41', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      'eb3336cb-887d-4239-a20a-4a491df5acea', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('71c55a12-55a1-4d6e-a6a2-4b68a9352177', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '16a71b1a-c90e-440d-973b-a88c60ec9cf2', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();
INSERT INTO shop_stock (id, shop_id, item_id, packaging_units, loose_pieces, created_at, updated_at) 
    VALUES ('a89ec082-7bcf-4000-a8d7-e227ed56fe5c', 
      COALESCE((SELECT id FROM shops WHERE name = 'VC'), '8054fcba-d23a-4764-bce9-8280648c8974'), 
      '09096d6a-ad7e-43b3-a456-de20f33d1fe6', 
      0, 
      0, 
      NOW(), 
      NOW()) 
    ON CONFLICT (shop_id, item_id) DO UPDATE SET packaging_units = EXCLUDED.packaging_units, loose_pieces = EXCLUDED.loose_pieces, updated_at = NOW();