-- Insert all 11 shops
-- This migration adds all shop locations to the database
-- Uses ON CONFLICT to prevent errors if shops already exist

INSERT INTO shops (name) VALUES
  ('Winkel Rijks'),
  ('Ponton Rijks'),
  ('ARK Rijks'),
  ('Leidse'),
  ('CS Oost'),
  ('Bridge'),
  ('Damrak 5'),
  ('Damrak 6'),
  ('Vlaggenwinkel'),
  ('Damrak 4'),
  ('VC')
ON CONFLICT (name) DO NOTHING;

