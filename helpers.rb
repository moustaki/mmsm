helpers do
  def monster_greetings
    %w(Hello... Greetings. Hi!).sample
  end
  
  def monster_nickname
    %w(monster ghoul zombie vampire ninja robot dragon beast demon monstrosity fiend freak).sample
  end
  
  def track_appreciation(track)
    if track.hotttnesss > 0.6
        return 'great'
    elsif track.hotttnesss > 0.3
        return 'mild'
    else
        return 'terrible'
    end
  end
  
  def sad_monster
    ['I want to cry.', 'My existence is meaningless...', 'What a loser.'].sample
  end
  
  def monster_adjective
    %w(scary hideous terrible fierce courageous tough).sample
  end
  
  def monster_shape(i)
    %w(circle point line triangle square pentagon hexagon heptagon octagon nonagon decagon hendecagon dodecagon)[i]
  end
end
