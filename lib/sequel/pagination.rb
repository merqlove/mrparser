# These helper methods add a .page method that works for pagination with ORM objects and datasets.
# Basically they save the "page = (page || 1).to_i".

# Define a class method to paginate through ORM models
class Sequel::Model
  def self.page(page, per_page=10, *args)
    # The page number comes as a string from the Sinatra controller.
    # Turn it into an integer and make it 1 if it was nil.
    page = (page || 1).to_i
    dataset.paginate(page, per_page, *args)
  end
end

# Define a class method to paginate through datasets
class Sequel::Dataset
  def page(page, per_page=10, *args)
    # The page number comes as a string from the Sinatra controller.
    # Turn it into an integer and make it 1 if it was nil.
    page = (page || 1).to_i
    paginate(page, per_page, *args)
  end
end