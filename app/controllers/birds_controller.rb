class BirdsController < ApplicationController
  before_action :find_bird, only: %i[show update]

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    if @bird
      render json: @bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    if @bird
      @bird.update(bird_params)
      render json: @bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  def increment_likes
    if @bird
      @bird.update(likes: @bird.likes + 1)
      render json: @bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  private

  def find_bird
    @bird = Bird.find_by(id: params[:id])
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end
end
