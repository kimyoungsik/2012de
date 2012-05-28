module SeedsHelper
  
  def seed_level(seed)
    if seed.point > 100
      "level1"
    elsif seed.point > 75
      "level2"
    elsif seed.point > 50
      "level3"
    elsif seed.point > 25
      "level4"
    else
      "level5"
    end
  end

end
