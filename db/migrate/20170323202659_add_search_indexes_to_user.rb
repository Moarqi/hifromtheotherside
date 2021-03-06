class AddSearchIndexesToUser < ActiveRecord::Migration[5.0]
  def up
    %w(email first_name last_name).each do |col|
      execute "create index on users using gin(to_tsvector('english', #{col}));"
      execute "CREATE INDEX trgm_#{col}_indx ON users USING gist (#{col} gist_trgm_ops);"
    end
    add_index :users, :zip
    add_index :users, :supported
    add_index :users, :desired
    add_index :users, 'zip text_pattern_ops'
  end
end
