require 'pry'
module CompaniesHelper
  def tree(c)
    @result = ""
    Company.where(master_company_id: c.id).each do |cn|
      @result += content_tag(:tr, :class => "list") do
          concat(content_tag(:td) do
            for i in 0..(cn.nesting_level - 1)
              concat('-')
            end
            concat(cn.name)
          end)
          concat(content_tag(:td) do
            concat(cn.earnings)
          end)
          concat(content_tag(:td) do
            if Company.where(master_company_id: cn.id).count != 0
              concat(childEarnings(cn))
            end
          end)
          concat(content_tag(:td) do
            link_to 'Show', cn
          end)
          concat(content_tag(:td) do
            link_to 'Edit', edit_company_path(cn)
          end)
          concat(content_tag(:td) do
            link_to "Destroy", cn, method: :delete
          end)
      end
      @result += tree(cn)
    end
    #binding.pry
    @result.html_safe
  end

  def childEarnings(c)
    @result = c.earnings
    Company.where(master_company_id: c.id).each do |cn|
      @result += childEarnings(cn)
    end
    @result
  end
end
