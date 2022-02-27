class TodosController < ApplicationController
  #before_actionで,アクション前に実行されるメソッドを定義しています。
  #参考:https://qiita.com/ebi_death/items/3912630e32268c9cce46 
    before_action :authenticate_user!
    before_action :set_goal
  # before_action :set_todo, only: %i[ show edit update destroy ]
    before_action :set_todo, only: %i[:show, :edit, :update, :destroy, :sort]

  # GET /todos
  # def index
  #  @todos = Todo.all
  # end

  # GET /todos/1
  # def show
  # end

  # GET /todos/new
  def new
  #  @todo = Todo.new
  ## @goalに紐付いたtodosをnewしています
     @todo = @goal.todos.new 
  end

  # GET /todos/1/edit
  def edit
  end

  def sort
  end

  # POST /todos
  def create
  #  @todo = Todo.new(todo_params)
    @todo = @goal.todos.new(todo_params)

    if @todo.save
    #  redirect_to @todo, notice: "Todo was successfully created."
      @status = true
    else
    #  render :new, status: :unprocessable_entity
      @status = false
    end
  end

  # PATCH/PUT /todos/1
  def update
  # todo_paramsはこのクラスのprivate以下で定義しています。
    if @todo.update(todo_params)
    # redirect_to @todo, notice: "Todo was successfully updated."
      @status = true
    else
    #  render :edit, status: :unprocessable_entity
      @status = false
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  #  redirect_to todos_url, notice: "Todo was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = current_user.goals.find_by(id: params[:goal_id])
    redirect_to(goal_url, alert: "ERROR!!") if @goal.blank?
  end

  def set_todo
    # @todo = Todo.find(params[:id])
     @todo = @goal.todos.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:content, :goal_id, :position, :done)
  end
end
