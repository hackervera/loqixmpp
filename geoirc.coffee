irc = require 'irc'
xmpp = require 'node-xmpp'
config = require('./config').config
console.log config
client = new irc.Client(config.server, config.nick, config.options)
client.addListener 'registered', ->
    console.log 'registered'

client.addListener 'message', (from, to, message)->
    if match = message.match(/.*?twitter.com\/tylergillies.*?(http.*?)$/)
            console.log match[1]
            pres = new xmpp.Element('presence').c('status').t(match[1])
            cl = new xmpp.Client
                jid: config.jid
                password: config.jid_password       
            cl.addListener 'online', ->
                console.log pres.toString()
                cl.send pres
client.on 'error', (err)->
    console.log err