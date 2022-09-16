class UsersController < ApplicationController
    # before_action :authorize, except: [:create]
    skip_before_action :authorize, only: [:create]

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            # byebug
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        render json: user, status: :created
    end

    private

    def user_params
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
    end

    # def authorize
    #     return render json: {errors: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    # end
end
