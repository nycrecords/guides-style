# @author Mike Bland (michael.bland@gsa.gov)

require_relative './assets'
require_relative './breadcrumbs'
require_relative './layouts'
require_relative './namespace_flattener'

require 'jekyll'

module GuidesStyle18F
  class Generator < ::Jekyll::Generator
    def generate(site)
      Layouts.register site
      Assets.copy_to_site site
      pages = site.collections['pages']
      docs = (pages.nil? ? [] : pages.docs) + site.pages
      breadcrumbs = Breadcrumbs.create(site)
      docs.each { |page| page.data['breadcrumbs'] = breadcrumbs[page.url] }
      NamespaceFlattener.flatten_url_namespace(site, docs)
    end
  end
end
