class AdmissionAppMailer < ActionMailer::Base

  require 'axlsx' 

  default from: "admission@yartrans.ua"

  def new_app_to_manager(admission_app)

  	@app = app = admission_app


    p = Axlsx::Package.new

    p.workbook do |wb|

      # define your regular styles
      styles = wb.styles
      
      title = styles.add_style :bg_color => "C00000", :fg_color => 'FF', :sz => 16, :b => true, :width => :auto
      table_header = styles.add_style :bg_color => 'C3C3C3', :fg_color => '303030', :b => true, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto
      default = styles.add_style :b => false, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto

      wb.add_worksheet(name: 'Заявка на прием груза') do  |ws|
        ws.add_row ['ЗАЯВКА НА ПРИМЕМ ГРУЗА'], :style => title
        ws.add_row [app.user.profile.name], :style => title

        ws.merge_cells 'A1:E1'
        ws.merge_cells 'A2:E2'

        ws.add_row
        ws.add_row ['Номер зявки', 'Создана', 'Дата приема', 'Желаемое время', 'Примечания' ], :style => table_header
        ws.add_row [app.id, app.created_at.to_formatted_s(:db).first(10), app.admission_date.to_formatted_s(:db).first(10), app.admission_time.to_formatted_s(:db).last(8), app.notes ], :style => default
        ws.add_row
        ws.add_row ['ТМЦ', 'Артикул', 'Штрих-код', 'Единица', 'Количество', 'В коробке', 'Кол. коробок', 'Вес коробки', 'Объем коробки', 'Доп. услуги' ], :style => table_header
        for item in app.admission_items do
          ws.add_row [  item.name,
                        item.code_number,
                        item.bar_code,
                        item.unit,
                        item.unit_count,
                        item.in_box_count,
                        item.box_count,
                        item.box_weight,
                        item.box_size,
                        item.add_services ], :style => default
        end
        ws.column_widths nil, 20, 20, 20, 20, 20, 20, 20, 20, nil
      end

    end

    app_file_name = "#{app.created_at.to_datetime.to_formatted_s(:db).tr(' ', '_').tr(':', '-')}_admission_app.xlsx"

    app_file = p.to_stream()

    File.open('sample.xlsx', 'w') { |f| f.write(app_file.read) }

    attachments[app_file_name] = File.read('sample.xlsx')

  	mail(:to => 'mcmegavolt@gmail.com', :subject => 'New admission app created!')

  end

end
