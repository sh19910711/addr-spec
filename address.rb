def validate_address(address)
  addr_spec === address
end

def atext
  /([a-zA-Z])|([0-9])|\!|\#|\$|\%|\&|\'|\*|\+|\-|\/|\=|\?|\^|\_|\`|\{|\}|\||\~/
end

def dot_atom
  /(#{atext})+(\.(#{atext})+)*/
end

def quoted_string
  /\"((#{fws})?#{qcontent})*(#{fws})?\"/
end

def fws
  /\ /
end

def quoted_pair
  /\\([a-zA-Z0-9\ \"])/
end

def qtext
  /([a-zA-Z])|([0-9])|\!|\#|\$|\%|\&|\'|\*|\+|\-|\/|\=|\?|\^|\_|\`|\{|\}|\||\~|\.|\(|\)|\<|\>/
end

def qcontent
  /(#{qtext})|(#{quoted_pair})/
end

def local_part
  /(#{dot_atom})|(#{quoted_string})/
end

def domain
  "example.com"
end

def addr_spec
  /^(#{local_part})@(#{domain})$/
end
