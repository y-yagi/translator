class Edict < ApplicationRecord
  class << self
    def import_from_edict_file!
      file_path = Rails.root.join('tmp', 'edict_utf8.txt').to_s
      edicts = []
      File.open(file_path) do |file|
        file.each_line do |line|
          japanese, japanese_yomi, english, english_summary = parse_and_generate_sql(line)

          next if japanese.blank? || japanese_yomi.blank? || english.blank?
          edicts << Edict.new(
            japanese: japanese, japanese_yomi: japanese_yomi,
            english: english, english_summary: english_summary
          )
        end
      end
      Edict.import(edicts)
    end

    def parse_and_generate_sql(line)
      match_data = /(.*?)\[(.*?)\]\s+\/(.*)/.match(line)
      return unless match_data

      japanese = match_data[1].strip
      japanese_yomi = match_data[2]
      english = match_data[3].split("/").map { |word| word.sub(/\A\(.*?\)\s+(\w)/, '\1').sub(/\([0-9]\)\s+/, '') }
      english_summary = match_data[3]

      [japanese, japanese_yomi, english, english_summary]
    end

    def search(word)
      edicts = Edict.where("? = ANY (english)", word)
      return edicts if edicts.present?

      edicts = Edict.where("english_summary ilike ?", "%#{word}%")
      return edicts if edicts.present?

      []
    end
  end
end

