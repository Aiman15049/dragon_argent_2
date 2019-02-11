class CreateDynamicPageTable < ActiveRecord::Migration[6.0]
  def change
    create_table :dynamic_pages, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :ancestry
      t.integer :position
      t.integer :asset_id
      t.text :intro
      t.text :meta_description
      t.string :meta_title
      t.integer :owner_id
      t.string :owner_type
      t.string :slug
      t.string :static_descriptor
      t.string :title
      t.string :workflow_state
      t.timestamps
    end
    add_index :dynamic_pages, :ancestry
    add_index :dynamic_pages, :asset_id
    add_index :dynamic_pages, :meta_title
    add_index :dynamic_pages, :owner_id
    add_index :dynamic_pages, :owner_type
    add_index :dynamic_pages, [:owner_id, :owner_type], name: 'owner'
    add_index :dynamic_pages, :position
    add_index :dynamic_pages, :slug
    add_index :dynamic_pages, :static_descriptor
    add_index :dynamic_pages, :title
    add_index :dynamic_pages, :workflow_state
  end
end
