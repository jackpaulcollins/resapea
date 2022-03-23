class UpdateRecipeOp
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
  

  protected 

end