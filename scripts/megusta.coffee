# Description:
#   Happiness in image form
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   me gusta - Display "Me Gusta" face when heard
#
# Author:
#   phyreman

#module.exports = (robot) ->
#  robot.hear /me gusta/i, (msg) ->
#    msg.send "https://i.imgur.com/5VDqvND.png"
#
gustas = [
  "https://i.imgur.com/5VDqvND.png",
  "https://i.imgur.com/83BX6.jpg",
  "https://i.imgur.com/s4y5WA8.jpg"
]

module.exports = (robot) ->
  robot.hear /.*(me gusta).*/i, (msg) ->
      msg.send msg.random gustas
