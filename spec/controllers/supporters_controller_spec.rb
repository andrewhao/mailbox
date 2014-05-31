require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SupportersController do

  # This should return the minimal set of attributes required to create a valid
  # Supporter. As you add validations to Supporter, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SupportersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all supporters as @supporters" do
      supporter = Supporter.create! valid_attributes
      get :index, {}, valid_session
      assigns(:supporters).should eq([supporter])
    end
  end

  describe "GET show" do
    it "assigns the requested supporter as @supporter" do
      supporter = Supporter.create! valid_attributes
      get :show, {:id => supporter.to_param}, valid_session
      assigns(:supporter).should eq(supporter)
    end
  end

  describe "GET new" do
    it "assigns a new supporter as @supporter" do
      get :new, {}, valid_session
      assigns(:supporter).should be_a_new(Supporter)
    end
  end

  describe "GET edit" do
    it "assigns the requested supporter as @supporter" do
      supporter = Supporter.create! valid_attributes
      get :edit, {:id => supporter.to_param}, valid_session
      assigns(:supporter).should eq(supporter)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Supporter" do
        expect {
          post :create, {:supporter => valid_attributes}, valid_session
        }.to change(Supporter, :count).by(1)
      end

      it "assigns a newly created supporter as @supporter" do
        post :create, {:supporter => valid_attributes}, valid_session
        assigns(:supporter).should be_a(Supporter)
        assigns(:supporter).should be_persisted
      end

      it "redirects to the created supporter" do
        post :create, {:supporter => valid_attributes}, valid_session
        response.should redirect_to(Supporter.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved supporter as @supporter" do
        # Trigger the behavior that occurs when invalid params are submitted
        Supporter.any_instance.stub(:save).and_return(false)
        post :create, {:supporter => { "name" => "invalid value" }}, valid_session
        assigns(:supporter).should be_a_new(Supporter)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Supporter.any_instance.stub(:save).and_return(false)
        post :create, {:supporter => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested supporter" do
        supporter = Supporter.create! valid_attributes
        # Assuming there are no other supporters in the database, this
        # specifies that the Supporter created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Supporter.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => supporter.to_param, :supporter => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested supporter as @supporter" do
        supporter = Supporter.create! valid_attributes
        put :update, {:id => supporter.to_param, :supporter => valid_attributes}, valid_session
        assigns(:supporter).should eq(supporter)
      end

      it "redirects to the supporter" do
        supporter = Supporter.create! valid_attributes
        put :update, {:id => supporter.to_param, :supporter => valid_attributes}, valid_session
        response.should redirect_to(supporter)
      end
    end

    describe "with invalid params" do
      it "assigns the supporter as @supporter" do
        supporter = Supporter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Supporter.any_instance.stub(:save).and_return(false)
        put :update, {:id => supporter.to_param, :supporter => { "name" => "invalid value" }}, valid_session
        assigns(:supporter).should eq(supporter)
      end

      it "re-renders the 'edit' template" do
        supporter = Supporter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Supporter.any_instance.stub(:save).and_return(false)
        put :update, {:id => supporter.to_param, :supporter => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested supporter" do
      supporter = Supporter.create! valid_attributes
      expect {
        delete :destroy, {:id => supporter.to_param}, valid_session
      }.to change(Supporter, :count).by(-1)
    end

    it "redirects to the supporters list" do
      supporter = Supporter.create! valid_attributes
      delete :destroy, {:id => supporter.to_param}, valid_session
      response.should redirect_to(supporters_url)
    end
  end

end
