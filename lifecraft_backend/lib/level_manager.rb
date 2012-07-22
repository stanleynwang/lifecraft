class LevelManager
  @@base_xp = 100
  @@level_factor = 2
  @@level_func = lambda {|level| @@base_xp * (level**@@level_factor)}

  def self.required_exp(level)
    sum = 0
    0.upto(level-1) do |i|
      sum += @@level_func.call(i)
    end

    sum
  end

  def self.new_level(old_level, old_xp)
    old_req = self.required_exp(old_level)
    new_levels = 0
    cur_level = old_level + 1
    new_levels += 1 while old_xp >= self.required_exp(cur_level + new_levels)

    old_level + new_levels
  end
end
