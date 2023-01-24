class User
  	def self.query
    	Query.new(table: "users")
	end
end

class Query
	def initialize(table:)
		@table = table
		@where = []
		@order = []
		@limit = nil
		@offset = nil
	end

	def where(str)
		@where << str
		self
	end

	def order(str)
		@order << str
		self
	end

	def limit(l)
		@limit = l
		self
	end

	def offset(o)
		@offset = o
		self
	end

	def to_sql
		select_from = "SELECT * FROM #{@table}"
		where = "WHERE #{@where.join(" AND ")}" if @where.any?
		order = "ORDER BY #{@order.join(", ")}" if @order.any?
		limit = "LIMIT #{@limit}" if limit
		offset = "OFFSET #{@offset}" if @offset

		[select_from, where, order, limit, offset].compact.join(" ")
	end
end

puts User.query
		 .where("active = true")
		 .where("first_name ='Test'")
		 .order("birth_date DESC")
		 .limit(5)
		 .offset(25)
		 .to_sql
