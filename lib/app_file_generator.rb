class AppFileGenerator
	
	require 'axlsx'

	def self.admission_file_name(app)
		"priem_#{app.id.to_s}_ot_#{app.created_at.to_datetime.to_formatted_s(:db).tr(' ', '_').tr(':', '-')}.xlsx"
	end

	def self.release_file_name(app)
		"vydacha_#{app.id.to_s}_ot_#{app.created_at.to_datetime.to_formatted_s(:db).tr(' ', '_').tr(':', '-')}.xlsx"
	end

	def self.render_admission_xlsx_file(app)

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

        ws.merge_cells 'A1:J1'
        ws.merge_cells 'A2:J2'

        ws.add_row
        ws.add_row ['Номер зявки', 'Создана', 'Дата приема', 'Желаемое время', 'Данные об авто', 'Примечания' ], :style => table_header
        ws.add_row [app.id, app.created_at.to_formatted_s(:db).first(10), app.admission_date.to_formatted_s(:db).first(10), app.admission_time.to_formatted_s(:db).last(8), app.vehicle, app.notes ], :style => default
        ws.add_row
        ws.add_row ['ТМЦ', 'Артикул', 'Штрих-код', 'Единица', 'Количество', 'В коробке', 'Кол. коробок', 'Вес коробки, кг', 'Объем коробки, м3', 'Доп. информация' ], :style => table_header
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
                        item.add_services ], :style => default,
                        :types => [:string, :string, :string, :string, :integer, :integer, :integer, :integer, :integer, :string ]
        end
        ws.column_widths nil, 20, 20, 20, 20, 20, 20, 20, 20, nil
      end

    end
    p
  end


  def self.render_release_xlsx_file(app)

    p = Axlsx::Package.new

    p.workbook do |wb|

      # define your regular styles
      styles = wb.styles
      
      title = styles.add_style :bg_color => "00921C", :fg_color => 'FF', :sz => 16, :b => true, :width => :auto
      table_header = styles.add_style :bg_color => 'C3C3C3', :fg_color => '303030', :b => true, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto
      default = styles.add_style :b => false, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto

      wb.add_worksheet(name: 'Заявка на выдачу груза') do  |ws|
        ws.add_row ['ЗАЯВКА НА ВЫДАЧУ ГРУЗА'], :style => title
        ws.add_row [app.user.profile.name], :style => title
        ws.merge_cells 'A1:G1'
        ws.merge_cells 'A2:G2'
        ws.add_row
        ws.add_row ['Номер зявки', 'Создана', 'Дата приема', 'Желаемое время', 'Кому выдать', 'Данные об авто', 'Примечания' ], :style => table_header
        ws.add_row [app.id, app.created_at.to_formatted_s(:db).first(10), app.release_date.to_formatted_s(:db).first(10), app.release_time.to_formatted_s(:db).last(8), app.recipient, app.vehicle ,app.notes ], :style => default
        ws.add_row
        ws.add_row ['ТМЦ', 'Артикул', 'Штрих-код', 'Единица', 'Количество', 'Кол. коробок', 'Доп. информация' ], :style => table_header
        for item in app.release_items do
          ws.add_row [  item.name,
                        item.code_number,
                        item.bar_code,
                        item.unit,
                        item.unit_count,
                        item.box_count,
                        item.add_services ], :style => default,
                        :types => [:string, :string, :string, :string, :integer, :integer, :string ]
        end
        ws.column_widths 40, 20, 20, 20, 20, 20, 20, 20, 20, 40
      end

    end
    p
  end


# Samples generators

  def self.admission_app_sample(profile)

    p = Axlsx::Package.new

    p.workbook do |wb|

      # define your regular styles
      styles = wb.styles
      
      title = styles.add_style :bg_color => "C00000", :fg_color => 'FF', :sz => 16, :b => true, :width => :auto
      table_header = styles.add_style :bg_color => 'C3C3C3', :fg_color => '303030', :b => true, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto
      default = styles.add_style :b => false, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto

      wb.add_worksheet(name: 'Заявка на прием груза') do  |ws|
        ws.add_row ['ЗАЯВКА НА ПРИМЕМ ГРУЗА'], :style => title
        ws.add_row [profile.name], :style => title
        ws.add_row [profile.personal_id], :style => title
        ws.merge_cells 'A1:J1'
        ws.merge_cells 'A2:J2'
        ws.merge_cells 'A3:J3'
        ws.add_row
        ws.add_row ['Номер зявки', 'Создана', 'Дата приема', 'Желаемое время', 'Данные об авто', 'Примечания' ], :style => table_header
        ws.add_row ['заполняет оператор', Time.now.to_formatted_s(:db).first(10), Time.now.to_formatted_s(:db).first(10), Time.now.to_formatted_s(:db).last(8), '-', '-' ], :style => default
        ws.add_row
        ws.add_row ['ТМЦ', 'Артикул', 'Штрих-код', 'Единица', 'Количество', 'В коробке', 'Кол. коробок', 'Вес коробки, кг', 'Объем коробки, м3', 'Доп. информация' ], :style => table_header

        ws.column_widths nil, 20, 20, 20, 20, 20, 20, 20, 20, nil
      end

    end
    p
  end

  def self.release_app_sample(profile)
    p = Axlsx::Package.new

    p.workbook do |wb|

      # define your regular styles
      styles = wb.styles
      
      title = styles.add_style :bg_color => "00921C", :fg_color => 'FF', :sz => 16, :b => true, :width => :auto
      table_header = styles.add_style :bg_color => 'C3C3C3', :fg_color => '303030', :b => true, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto
      default = styles.add_style :b => false, :alignment => {:horizontal => :center, :vertical => :center}, :width => :auto

      wb.add_worksheet(name: 'Заявка на выдачу груза') do  |ws|
        ws.add_row ['ЗАЯВКА НА ВЫДАЧУ ГРУЗА'], :style => title
        ws.add_row [profile.name], :style => title
        ws.add_row [profile.personal_id], :style => title
        ws.merge_cells 'A1:G1'
        ws.merge_cells 'A2:G2'
        ws.merge_cells 'A3:G3'
        ws.add_row
        ws.add_row ['Номер зявки', 'Создана', 'Дата приема', 'Желаемое время', 'Кому выдать', 'Данные об авто', 'Примечания' ], :style => table_header
        ws.add_row ['заполняет оператор', Time.now.to_formatted_s(:db).first(10), Time.now.to_formatted_s(:db).first(10), Time.now.to_formatted_s(:db).first(10), '-', '-' , '-' ], :style => default
        ws.add_row
        ws.add_row ['ТМЦ', 'Артикул', 'Штрих-код', 'Единица', 'Количество', 'Кол. коробок', 'Доп. информация' ], :style => table_header
        ws.column_widths 40, 20, 20, 20, 20, 20, 20, 20, 20, 40
      end

    end
    p
  end


end