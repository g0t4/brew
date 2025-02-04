# typed: false
# frozen_string_literal: true

require "utils"

describe Utils do
  describe ".deconstantize" do
    it "removes the rightmost segment from the constant expression in the string" do
      expect(described_class.deconstantize("Net::HTTP")).to eq("Net")
      expect(described_class.deconstantize("::Net::HTTP")).to eq("::Net")
      expect(described_class.deconstantize("String")).to eq("")
      expect(described_class.deconstantize("::String")).to eq("")
    end

    it "returns an empty string if the namespace is empty" do
      expect(described_class.deconstantize("")).to eq("")
      expect(described_class.deconstantize("::")).to eq("")
    end
  end

  describe ".demodulize" do
    it "removes the module part from the expression in the string" do
      expect(described_class.demodulize("Foo::Bar")).to eq("Bar")
    end

    it "returns the string if it does not contain a module expression" do
      expect(described_class.demodulize("FooBar")).to eq("FooBar")
    end

    it "returns an empty string if the namespace is empty" do
      expect(described_class.demodulize("")).to eq("")
      expect(described_class.demodulize("::")).to eq("")
    end
  end

  describe ".pluralize" do
    it "combines the stem with the default suffix based on the count" do
      expect(described_class.pluralize("foo", 0)).to eq("foos")
      expect(described_class.pluralize("foo", 1)).to eq("foo")
      expect(described_class.pluralize("foo", 2)).to eq("foos")
    end

    it "combines the stem with the singular suffix based on the count" do
      expect(described_class.pluralize("foo", 0, singular: "o")).to eq("foos")
      expect(described_class.pluralize("foo", 1, singular: "o")).to eq("fooo")
      expect(described_class.pluralize("foo", 2, singular: "o")).to eq("foos")
    end

    it "combines the stem with the plural suffix based on the count" do
      expect(described_class.pluralize("foo", 0, plural: "es")).to eq("fooes")
      expect(described_class.pluralize("foo", 1, plural: "es")).to eq("foo")
      expect(described_class.pluralize("foo", 2, plural: "es")).to eq("fooes")
    end

    it "combines the stem with the singular and plural suffix based on the count" do
      expect(described_class.pluralize("foo", 0, singular: "o", plural: "es")).to eq("fooes")
      expect(described_class.pluralize("foo", 1, singular: "o", plural: "es")).to eq("fooo")
      expect(described_class.pluralize("foo", 2, singular: "o", plural: "es")).to eq("fooes")
    end
  end

  describe ".underscore" do
    # commented out entries require acronyms inflections
    let(:words) {
      [
        ["API", "api"],
        ["APIController", "api_controller"],
        ["Nokogiri::HTML", "nokogiri/html"],
        # ["HTTPAPI", "http_api"],
        ["HTTP::Get", "http/get"],
        ["SSLError", "ssl_error"],
        # ["RESTful", "restful"],
        # ["RESTfulController", "restful_controller"],
        # ["Nested::RESTful", "nested/restful"],
        # ["IHeartW3C", "i_heart_w3c"],
        # ["PhDRequired", "phd_required"],
        # ["IRoRU", "i_ror_u"],
        # ["RESTfulHTTPAPI", "restful_http_api"],
        # ["HTTP::RESTful", "http/restful"],
        # ["HTTP::RESTfulAPI", "http/restful_api"],
        # ["APIRESTful", "api_restful"],
        ["Capistrano", "capistrano"],
        ["CapiController", "capi_controller"],
        ["HttpsApis", "https_apis"],
        ["Html5", "html5"],
        ["Restfully", "restfully"],
        ["RoRails", "ro_rails"],
      ]
    }

    it "converts strings to underscore case" do
      words.each do |camel, under|
        expect(described_class.underscore(camel)).to eq(under)
        expect(described_class.underscore(under)).to eq(under)
      end
    end
  end
end
