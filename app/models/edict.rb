class Edict < ApplicationRecord
  class << self
    def import_from_edict_file!
      file_path = Rails.root.join('tmp', 'edict_utf8.txt').to_s
      edicts = []
      File.open(file_path) do |file|
        file.each_line do |line|
          japanese, japanese_yomi, english = parse_and_generate_sql(line)

          next if japanese.blank? || japanese_yomi.blank? || english.blank?
          edicts << Edict.new(japanese: japanese, japanese_yomi: japanese_yomi, english: english)
        end
      end
      Edict.import(edicts)
    end

    def parse_and_generate_sql(line)
      match_data = /(.*?)\[(.*?)\]\s+\/(.*)/.match(line)
      return unless match_data

      japanese = match_data[1].strip
      japanese_yomi = match_data[2]
      english = match_data[3].split("/").map { |word| word.sub(/\(.*\)\s+/, '') }

      [japanese, japanese_yomi, english]
    end
  end
end

