require 'rails_helper'

RSpec.describe Back::System::CatagoriesController, :type => :controller do

  # 用admin用户登录
  describe "when admin sign in -- " do
    before(:each) do 
      @admin = create(:super_admin)
      sign_in :admin, @admin
    end

    # 一览
    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        expect(response).to be_success
      end
    end

    # 明细
    describe "GET 'show'" do
      it "should raise 404 exception" do
        expect_record_not_found do
          get :show, :id => 1
        end
      end

      it "should http success" do
        c = create(:catagory1)
        get :show, :id => c.id
        expect(response).to be_success
        expect(assigns(:catagory)).to eq(c)
      end
    end

    # 新建
    describe "GET 'new'" do
      it "should http success" do
        get 'new'
        expect(response).to be_success
        expect(assigns(:catagory)).to be_a_new(Catagory)
        expect(response).to render_template(:new)
      end
    end

    # 编辑
    describe "GET 'edit'" do
      it "should http success" do
        c = create(:catagory1)
        get :edit, id: c.id
        expect(response).to be_success
        expect(response).to render_template(:edit)
        expect(assigns(:catagory)).to eq(c)
      end

      it "should raise not found" do
        expect_record_not_found do
          get :edit, id: '99999'
        end
        expect(response).to be_success
      end
    end

    # 新建create
    describe "POST 'create'" do
      it "should render new when validate error" do
        post :create, :catagory => {name: ""}
        expect(response).to render_template(:new)
      end

      it "should redirect to show page" do
        post :create, :catagory => attributes_for(:catagory1) 
        expect(assigns(:catagory)).not_to be_a_new(Catagory)
        expect(response).to redirect_to(back_system_catagory_path(assigns(:catagory)))
      end
    end

    # 更新update
    describe "PUT 'update'" do
      it "should render new when validate error" do
        c = create(:catagory1)
        c.name = ''
        put :update, id: c.id, catagory: c.attributes
        expect(response).to render_template(:edit)
        expect(assigns(:catagory).errors).not_to be_empty
      end

      it "should redirect to show page" do
        c = create(:catagory1)
        c.name = name_modified = '更新'
        put :update, id: c.id, catagory: c.attributes
        expect(response).to redirect_to(back_system_catagory_path(c))
        expect(assigns(:catagory)).not_to be_nil
        expect(assigns(:catagory)).to eq(c)
        expect(assigns(:catagory).name).to eq(name_modified)
      end
    end

    # 删除
    describe "DELETE 'destroy'" do
      it "should raise not found " do
        expect_record_not_found do
          delete :destroy, id: 1
        end
      end

      it "should delete record and redirect to index" do
        c = create(:catagory1)
        expect(Catagory.find_by_id(c.id)).to eq(c)
        delete :destroy, id: c.id
        expect(Catagory.find_by_id(c.id)).to be_nil
        expect(response).to redirect_to(back_system_catagories_path)
      end
    end
  end

  # 未登录用户
  describe "when not sign in -- " do
    describe "GET 'index'" do
      it "redirect to sign in page" do
        get 'index'
        expect_redirect_to_admin_sign_in
      end
    end
  end

end
