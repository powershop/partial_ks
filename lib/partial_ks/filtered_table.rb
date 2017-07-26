module PartialKs
  class FilteredTable
    attr_reader :table, :parent_model, :custom_filter_relation
    delegate :table_name, :to => :table

    def initialize(model, parent_model, custom_filter_relation: nil)
      @table = PartialKs::Table.new(model)
      @parent_model = parent_model
      @custom_filter_relation = custom_filter_relation
    end

    def kitchen_sync_filter
      if custom_filter_relation
        {"only" => filter_based_on_custom_filter_relation}
      elsif parent_model
        {"only" => filter_based_on_parent_model}
      else
        nil
      end
    end

    protected
    def filter_based_on_parent_model
      table.relation_for_associated_model(parent_model).where_sql.to_s.sub(where_regexp, "")
    end

    def filter_based_on_custom_filter_relation
      relation = custom_filter_relation.respond_to?(:call) ? custom_filter_relation.call : custom_filter_relation

      if relation.is_a?(ActiveRecord::Relation) || relation.respond_to?(:where_sql)
        relation.where_sql.to_s.sub(where_regexp, "")
      elsif relation.is_a?(String)
        relation.sub(where_regexp, "")
      end
    end

    def where_regexp
      /\A.*WHERE\s*/i
    end
  end
end
