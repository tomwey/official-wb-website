ActiveAdmin.register Project do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :body, :cover, :sort, :opened, { tags: [] }
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
index do
  selectable_column
  column('ID', :uniq_id)
  column :cover, sortable: false do |o|
    image_tag o.cover.url(:small)
  end
  column :name, sortable: false
  column :tags, sortable: false
  column '浏览数', :visit
  column '显示顺序', :sort
  column '是否打开', :opened, sortable: false
  column 'at', :created_at
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :name
    f.input :cover, hint: '图片格式为jpg,png,gif,jpeg；尺寸为：610x458'
    f.input :body, as: :text, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :tags, as: :check_boxes, label: '所属标签', collection: Tag.all.map { |a| [a.name, a.code] }, required: true
    f.input :sort, label: '显示顺序', hint: '越小越靠前'
    f.input :opened, as: :boolean, label: '是否打开'
  end
  actions
  
end

end
