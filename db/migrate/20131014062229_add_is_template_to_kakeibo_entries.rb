class AddIsTemplateToKakeiboEntries < ActiveRecord::Migration
  def change
    add_column :kakeibo_entries, :is_template, :integer, :null => false, :default => 0
  end
end
