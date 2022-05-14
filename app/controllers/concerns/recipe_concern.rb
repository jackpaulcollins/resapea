# frozen_string_literal: true

module RecipeConcern
  extend ActiveSupport::Concern

  def picture_upload(_recipe, _picture)
    blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new((Base64.decode64(recipe_params[:picture].split(',')[1]))),
      filename: "#{@recipe.id}_#{Time.current.to_i}.jpeg",
      content_type: 'image/jpeg'
    )
    @recipe.picture.attach(blob)
    @recipe.photo_url = url_for(@recipe.picture)
    @recipe.save
  end

  def picture_update(_recipe, _picture)
    blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new((Base64.decode64(recipe_params[:picture].split(',')[1]))),
      filename: "#{@recipe.id}_#{Time.current.to_i}.jpeg",
      content_type: 'image/jpeg'
    )
    @recipe.picture.attach(blob)
    @recipe.photo_url = url_for(@recipe.picture)
    @recipe.save
  end

  def user_requesting_own_recipe_resource(resource)
    return @current_user.id == resource.user_id if resource.instance_of?(Recipe)

    @current_user.id == resource.recipe.user.id
  end
end
