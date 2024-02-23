class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:edit , :update ,:destroy, :like , :unlike]
    def index
        @post =Post.all
        @user =User.all
        @likes =Like.all
    end
    
    def new
        @post =Post.new
    end

    def create
        # @post = current_user.posts()
        @post = Post.new(post_params)
        @post.image.attach(params[:post][:image])
        if @post.save
            redirect_to posts_path ,notice: 'post sucessfully created'
        else
            render:new
        end
    end

    def edit
        
    
    end
    
    def update
        
        if @post.update(post_params)
            redirect_to posts_path,notice: 'post sucessfully updated'
        else
            render:edit
        end

    end
    
    def destroy
        @post.delete
        redirect_to posts_path,notice: 'post deleted sucessfully'
    end


    def like
        current_user.likes.create(post: @post)
        redirect_to posts_path, notice: 'Post liked!'
      end
    
      def unlike
        like = current_user.likes.find_by(post: @post)
        like.destroy if like
        redirect_to posts_path, notice: 'Post unliked!'
      end
      
    private
    def set_post
        @post = Post.find(params[:id])
    end
    
    
    def post_params
        params.require(:post).permit(:title ,:comment ,:image)
    end


end
