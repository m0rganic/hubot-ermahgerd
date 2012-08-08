# Description:
#   Ermahgerd Therts Ersum
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot ermahgerd <phrase> -- ersum ermahgerd translator
#
# Author:
#   m0rganic

module.exports = (robot) ->
  robot.respond /(ermahgerd) (.*)/i, (msg) ->
    msg.send ermahgerd(msg.match[2].toUpperCase())

ermahgerd = (word) ->
  # Don't translate short words
  return word  if word.length is 1

  # Handle specific words
  switch word
    when "AWESOME"
      return "ERSUM"
    when "BANANA"
      return "BERNERNER"
    when "BAYOU"
      return "BERU"
    when "FAVORITE", "FAVOURITE"
      return "FRAVRIT"
    when "GOOSEBUMPS"
      return "GERSBERMS"
    when "LONG"
      return "LERNG"
    when "MY"
      return "MAH"
    when "THE"
      return "DA"
    when "THEY"
      return "DEY"
    when "WE'RE"
      return "WER"
    when "YOU"
      return "U"
    when "YOU'RE"
      return "YER"

  # Before translating, keep a reference of the original word
  originalWord = word

  # Drop vowel from end of words
  # Keep it for short words, like "WE"
  word = word.replace(/[AEIOU]$/, "")  if originalWord.length > 2

  # Reduce duplicate letters
  word = word.replace(/[^\w\s]|(.)(?=\1)/g, "")

  # Reduce adjacent vowels to one
  word = word.replace(/[AEIOUY]{2,}/g, "E") # TODO: Keep Y as first letter

  # DOWN -> DERN
  word = word.replace(/OW/g, "ER")

  # PANCAKES -> PERNKERKS
  word = word.replace(/AKES/g, "ERKS")

  # The mean and potatoes: replace vowels with ER
  word = word.replace(/[AEIOUY]/g, "ER") # TODO: Keep Y as first letter

  # OH -> ER
  word = word.replace(/ERH/g, "ER")

  # MY -> MAH
  word = word.replace(/MER/g, "MAH")

  # FALLING -> FERLIN
  word = word.replace("ERNG", "IN")

  # POOPED -> PERPERD -> PERPED
  word = word.replace("ERPERD", "ERPED")

  # MEME -> MAHM -> MERM
  word = word.replace("MAHM", "MERM")

  # Keep Y as first character
  # YES -> ERS -> YERS
  word = "Y" + word  if originalWord.charAt(0) is "Y"

  # Reduce duplicate letters
  word = word.replace(/[^\w\s]|(.)(?=\1)/g, "")

  # YELLOW -> YERLER -> YERLO
  word = word.substr(0, word.length - 3) + "LO"  if (originalWord.substr(-3) is "LOW") and (word.substr(-3) is "LER")
  word
