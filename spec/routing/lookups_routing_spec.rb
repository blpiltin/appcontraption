require "spec_helper"

describe LookupsController do
  describe "routing" do

    it "routes to #index" do
      get("/lookups").should route_to("lookups#index")
    end

    it "routes to #new" do
      get("/lookups/new").should route_to("lookups#new")
    end

    it "routes to #show" do
      get("/lookups/1").should route_to("lookups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lookups/1/edit").should route_to("lookups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lookups").should route_to("lookups#create")
    end

    it "routes to #update" do
      put("/lookups/1").should route_to("lookups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lookups/1").should route_to("lookups#destroy", :id => "1")
    end

  end
end
