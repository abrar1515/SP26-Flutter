# Supabase CRUD App - Database Setup

Copy and paste these SQL queries into your Supabase SQL Editor to set up the database schema and Row Level Security (RLS) policies.

## 1. Create the Items Table

```sql
-- Drop table if it exists (for fresh setup)
DROP TABLE IF EXISTS items CASCADE;

-- Create items table
CREATE TABLE items (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create indexes for better query performance
CREATE INDEX idx_items_created_at ON items(created_at DESC);
CREATE INDEX idx_items_title ON items(title);
```

## 2. Enable Row Level Security (RLS)

```sql
-- Enable RLS on items table
ALTER TABLE items ENABLE ROW LEVEL SECURITY;
```

## 3. Create RLS Policies

```sql
-- Policy: Allow all authenticated users to SELECT items
CREATE POLICY "Allow authenticated users to select items"
ON items
FOR SELECT
TO authenticated
USING (true);

-- Policy: Allow all authenticated users to INSERT items
CREATE POLICY "Allow authenticated users to insert items"
ON items
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Policy: Allow all authenticated users to UPDATE items
CREATE POLICY "Allow authenticated users to update items"
ON items
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- Policy: Allow all authenticated users to DELETE items
CREATE POLICY "Allow authenticated users to delete items"
ON items
FOR DELETE
TO authenticated
USING (true);

-- Optional: Allow anonymous users (if using anon key)
CREATE POLICY "Allow anon users to select items"
ON items
FOR SELECT
TO anon
USING (true);

CREATE POLICY "Allow anon users to insert items"
ON items
FOR INSERT
TO anon
WITH CHECK (true);

CREATE POLICY "Allow anon users to update items"
ON items
FOR UPDATE
TO anon
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow anon users to delete items"
ON items
FOR DELETE
TO anon
USING (true);
```

## 4. Grant Permissions (if needed)

```sql
-- Grant permissions to authenticated users
GRANT SELECT, INSERT, UPDATE, DELETE ON items TO authenticated;

-- Grant permissions to anonymous users (if using anon key)
GRANT SELECT, INSERT, UPDATE, DELETE ON items TO anon;
```

## 5. Insert Sample Data (Optional)

```sql
-- Insert sample items for testing
INSERT INTO items (title, description) VALUES
('Learn Flutter', 'Complete Flutter course on Udemy'),
('Build CRUD App', 'Create a full-stack CRUD application with Supabase'),
('Deploy to Production', 'Set up CI/CD and deploy the app');
```

## Setup Instructions:

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Create a new query and copy-paste each SQL block above (one at a time or all together)
4. Execute the queries
5. Verify the table and policies are created by checking the **Table Editor** and **Authentication** → **Policies**

## Notes:

- The `id` field is auto-generated (IDENTITY)
- `created_at` and `updated_at` are automatically set to the current UTC timestamp
- RLS is enabled to ensure data security
- Policies allow both authenticated and anonymous users to perform CRUD operations
- Adjust the policies based on your security requirements (e.g., restrict to authenticated users only)

## To Restrict to Authenticated Users Only (Enhanced Security):

Replace the RLS policies section with this:

```sql
-- More restrictive: Only authenticated users can access
CREATE POLICY "Allow authenticated users to select"
ON items
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Allow authenticated users to insert"
ON items
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update"
ON items
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow authenticated users to delete"
ON items
FOR DELETE
TO authenticated
USING (true);
```
