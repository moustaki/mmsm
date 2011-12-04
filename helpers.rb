helpers do
  def monster_greetings
    %w(Hello... Greetings. Hi!).sample
  end
  
  def monster_nickname
    %w(monster pet).sample
  end
  
  def track_appreciation(track)
    %w(great! terrible. mild).sample
  end
  
  def sad_monster
    ['I want to cry.', 'My existence is meaningless...', 'What a loser.'].sample
  end
  
  def monster_shape
    %w(circle triangle square pentagon hexagon heptagon octagon nonagon decagon hendecagon dodecagon).sample
  end
end
