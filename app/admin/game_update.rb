ActiveAdmin.register GameUpdate do
  menu parent: 'game', priority: 3, label: '游戏更新'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :version, :os, :game_id, :search_paths, :package_file, :change_log, :opened
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
  column :version
  column :os, sortable: false
  column '所属游戏', sortable: false do |o|
    o.game.try(:name)
  end
  column :search_paths, sortable: false
  column :change_log, sortable: false do |o|
    raw(o.change_log)
  end
  column 'at', :created_at
  
  actions
end


form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :version, placeholder: '1.0.0'
    f.input :os, as: :select, label: '平台', collection: ['iOS', 'Android']
    f.input :game_id, as: :select, collection: Game.all.map{ |g| [g.name, g.id] }, required: true#, prompt: '-- 选择游戏 --'
    # f.input :change_log, as: :text, label: '版本更新日志', rows: 10, cols: 30#, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :package_file, hint: '格式为zip或rar'
    f.input :search_paths,as: :text, rows: 6, placeholder: '客户端路径，多个路劲用英文逗号或回车分隔'
    f.input :opened, as: :boolean, label: '是否启用该版本'
    f.input :change_log, as: :text, input_html: { class: 'redactor' }, placeholder: '更新内容，支持图文混排', 
      hint: '更新内容，支持图文混排'
  end
  actions
end

end
