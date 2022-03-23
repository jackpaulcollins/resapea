class CreateRecipeOp
  delegate :id, to: :recipe, prefix: :recipe

  attr_reader :recipe,
              :recipe_title,
              :genre,
              :current_user_id,
              :instructions,
              :ingredients
  
  
  
  def initialize(params)
    @recipe = params.with_indifferent_access[:recipe]
    @recipe_title = params[:recipe_title]
    @genre = params[:genre]
    @current_user_id = params[:current_user_id]
    @instructions = params[:instructions]
    @ingredients = params[:ingredients]
  end
  
  def execute
    self.create_recipe.save &&
    self.create_recipe_ingredients.all?(&:save) &&
    self.create_recipe_instructions.all?(&:save)
  end

  def valid?
    self.create_recipe.valid? &
    self.validate_all(self.create_recipe_ingredients) &
    self.validate_all(self.create_recipe_instructions)
  end

  protected 

    def create_recipe
     @_recipe ||= Recipe.new(name: @recipe_title, genre: @genre, user_id: @current_user_id)
    end

    def create_recipe_ingredients
      @_ingredients || @ingredients.map do |ingredient|
        RecipeIngredient.new(
                                  recipe: self.create_recipe, 
                                  ingredient_name: ingredient[:name],
                                  measurement_unit_type: ingredient[:unit_type], 
                                  measurement_unit_quantity: ingredient[:quantity]
                                )
        end
    end

    def create_recipe_instructions
     @_instructions ||=  @instructions.map do |instruction|
        Instruction.new(recipe: self.create_recipe, content: instruction)
      end
    end

    def validate_all(models)
      models.inject(true) do |result, model|
        result &= model.valid?
      end
    end
end