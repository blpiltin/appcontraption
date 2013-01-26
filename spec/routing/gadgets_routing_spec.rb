require "spec_helper"

describe GadgetsController do
  describe "routing" do

    it "routes to #index" do
      get("/gadgets").should route_to("gadgets#index")
    end

    it "routes to #new" do
      get("/gadgets/new").should route_to("gadgets#new")
    end

    it "routes to #show" do
      get("/gadgets/1").should route_to("gadgets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/gadgets/1/edit").should route_to("gadgets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/gadgets").should route_to("gadgets#create")
    end

    it "routes to #update" do
      put("/gadgets/1").should route_to("gadgets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/gadgets/1").should route_to("gadgets#destroy", :id => "1")
    end

  end
end
