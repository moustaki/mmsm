helpers do
  def monster_greetings
    %w(Hello... Greetings. Hi!).sample
  end
  
  def monster_nickname
    %w(monster beast demon monstrosity fiend freak).sample
  end
  
  def track_appreciation(track)
    %w(great! terrible. mild).sample
  end
  
  def sad_monster
    ['I want to cry.', 'My existence is meaningless...', 'What a loser.'].sample
  end
  
  def monster_adjective
    %w(scary hideous terrible).sample
  end
  
  def monster_shape(i)
    %w(circle point line triangle square pentagon hexagon heptagon octagon nonagon decagon hendecagon dodecagon)[i]
  end
end
