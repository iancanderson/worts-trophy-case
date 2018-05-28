class TrophiesController < ApplicationController
  before_action :require_user!, except: [:index]

  def index
    @trophies = Trophy.order(competition_date: :desc)
  end

  def new
    @trophy = Trophy.new
  end

  def create
    @trophy = Trophy.new(trophy_params)

    if @trophy.save
      redirect_to root_path, flash: { notice: "Your trophy was created!" }
    else
      render "new"
    end
  end

  private

  def trophy_params
    params.require(:trophy).permit(
      :bjcp_score,
      :competition_date,
      :competition_url,
      :photo,
      :place,
      :place_context,
      :recipe_url,
      :subcategory_id,
    ).merge(user: current_user)
  end
end
