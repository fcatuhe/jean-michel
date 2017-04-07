# Seed Forfeits
forfeits_file = Rails.root.join('db', 'seeds', 'forfeits.yml')
forfeit_hashs = YAML::load_file(forfeits_file)

forfeit_hashs.each_with_index do |forfeit_hash, index|
  if forfeit = Forfeit.find_by(id: (index + 1))
    forfeit.update(
      description_fr: forfeit_hash['description_fr'],
      description_en: forfeit_hash['description_en']
    )
  else
    Forfeit.create(
      description_fr: forfeit_hash['description_fr'],
      description_en: forfeit_hash['description_en']
    )
  end
end

# Seed Signs
signs_file = Rails.root.join('db', 'seeds', 'signs.yml')
sign_hashs = YAML::load_file(signs_file)

sign_hashs.each_with_index do |sign_hash, index|
  if sign = Sign.find_by(id: (index + 1))
    sign.update(
      description_fr: sign_hash['description_fr'],
      description_en: sign_hash['description_en']
    )
  else
    Sign.create(
      description_fr: sign_hash['description_fr'],
      description_en: sign_hash['description_en']
    )
  end
end
