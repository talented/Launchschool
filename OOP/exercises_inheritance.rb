
class SecretThing

  def share_secret
    "The secret is #{self.secret}"
  end



  def secret
    "shhh.. it's a secret!!"
  end
end

puts SecretThing.new.share_secret # => "The secret is shhh.. it's a secret!!"
