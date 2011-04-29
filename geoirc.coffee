irc = require 'irc'
xmpp = require 'node-xmpp'
config = require('./config').config
console.log config
client = new irc.Client(config.server, config.nick, config.options)
cl = new xmpp.Client
    jid: config.jid
    password: config.jid_password 
client.addListener 'registered', ->
    console.log 'registered'
pres = null
cl.addListener 'online', ->
    setInterval (->
        if pres?
            console.log pres.toString()
            cl.send pres
        ), 5000
client.addListener 'message', (from, to, message)->
    if match = message.match(///.*?twitter.com/#{config.twittername}.*?(http.*?)$///)
            console.log match[1]
            pres = new xmpp.Element('presence').c('status').t(match[1])
           
client.on 'error', (err)->
    console.log err