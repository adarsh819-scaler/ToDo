class TodoItemsController < ApplicationController 
    before_action :set_todo_list
    before_action :set_todo_item, except: [:create]
def create
 @todo_item = @todo_list.todo_items.create(todo_item_params)
 redirect_to @todo_list
end
def update
    respond_to do |format|
      if @todo_list.todo_item.update(todo_list_params)
        format.html { redirect_to todo_list_url(@todo_list.todo_item), notice: "Todo list was successfully updated." }
        format.json { render :show, status: :ok, location: @todo_list.todo_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_list.todo_item.errors, status: :unprocessable_entity }
      end
    end
  end
def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
     flash[:success] = "Todo List item was deleted."
    else
     flash[:error] = "Todo List item could not be deleted."
    end
    redirect_to @todo_list 
end
def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item completed"
end  
private
def set_todo_list
 @todo_list = TodoList.find(params[:todo_list_id])
end
def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
end
def todo_item_params
 params[:todo_item].permit(:content)
end
end
