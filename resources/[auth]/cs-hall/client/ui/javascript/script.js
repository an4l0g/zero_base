let pendingSync = false
let pendingSeek = false
let pendingQueue = false
let playing = false
let stopped = false
let seekHiding = false
let lastUrl = null
let allowAllSources = false

const urlCheckElement = document.createElement('input')

urlCheckElement.setAttribute('type', 'url')

const notify = (text, type) => new Noty({
    type,
    layout: 'bottomRight',
    text,
    theme: 'sunset',
    timeout: 3000
}).show()

const ready = lang => {
    const elements = {
        queue: $('#queue'),
        addInput: $('#add-input'),
        addButton: $('#add-button'),
        scenesEnabled: $('#scenes-enabled'),
        bassSmoke: $('#bass-smoke'),
        bassSparklers: $('#bass-sparklers'),
        triggerSmoke: $('#trigger-smoke'),
        triggerSparklers: $('#trigger-sparklers'),
        whiteSpotlights: $('#white-spotlights'),
        dynamicSpotlights: $('#dynamic-spotlights'),
        photorythmicSpotlights: $('#photorythmic-spotlights'),
        videoToggle: $('#video-toggle'),
        screenControl: $('#screen-control'),
        remoteControl: $('#remote-control'),
        playButton: $('#play-button'),
        stopButton: $('#stop-button'),
        skipButton: $('#skip-button'),
        loopButton: $('#loop-button'),
        volumeControl: $('#volume-control'),
        volume: $('#volume'),
        volumeText: $('#volume-text'),
        playerContainer: $('#player-container'),
        seekControl: $('#seek-control'),
        seek: $('#seek'),
        seekStartText: $('#start-seek-text'),
        seekEndText: $('#end-seek-text'),
        mediaInfo: $('#media-info'),
        mediaTitle: $('#media-title'),
        mediaImage: $('#media-image'),
        close: $('#close')
    }

    tippy(elements.addButton.get(0), {
        content: lang.addToQueue
    })

    tippy(elements.scenesEnabled.get(0), {
        content: lang.scenes
    })

    tippy(elements.bassSmoke.get(0), {
        content: lang.bassSmoke
    })

    tippy(elements.bassSparklers.get(0), {
        content: lang.bassSparklers
    })

    tippy(elements.triggerSmoke.get(0), {
        content: lang.triggerSmoke
    })

    tippy(elements.triggerSparklers.get(0), {
        content: lang.triggerSparklers
    })

    tippy(elements.whiteSpotlights.get(0), {
        content: lang.whiteSpotlights
    })

    tippy(elements.dynamicSpotlights.get(0), {
        content: lang.dynamicSpotlights
    })

    tippy(elements.photorythmicSpotlights.get(0), {
        content: lang.photorythmicSpotlights
    })
    
    tippy(elements.videoToggle.get(0), {
        content: lang.videoToggle
    })

    tippy(elements.screenControl.get(0), {
        content: lang.screenControl
    })
    
    tippy(elements.remoteControl.get(0), {
        content: lang.remoteControl
    })

    tippy(elements.playButton.get(0), {
        content: lang.play
    })

    tippy(elements.stopButton.get(0), {
        content: lang.stop
    })

    tippy(elements.skipButton.get(0), {
        content: lang.skip
    })

    tippy(elements.loopButton.get(0), {
        content: lang.loop
    })

    tippy(elements.volumeText.get(0), {
        content: lang.volume
    })

    elements.scenesEnabled.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'scenesEnabled'
            })
        }).catch(() => {})
    })

    elements.bassSmoke.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'bassSmoke'
            })
        }).catch(() => {})
    })

    elements.bassSparklers.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'bassSparklers'
            })
        }).catch(() => {})
    })

    elements.triggerSmoke.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        fetch(`https://${GetParentResourceName()}/triggerSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'triggerSmoke'
            })
        }).catch(() => {})
    })

    elements.triggerSparklers.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        fetch(`https://${GetParentResourceName()}/triggerSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'triggerSparklers'
            })
        }).catch(() => {})
    })

    elements.whiteSpotlights.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'whiteSpotlights'
            })
        }).catch(() => {})
    })

    elements.dynamicSpotlights.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'dynamicSpotlights'
            })
        }).catch(() => {})
    })

    elements.photorythmicSpotlights.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'photorythmicSpotlights'
            })
        }).catch(() => {})
    })

    elements.videoToggle.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/toggleSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'videoToggle'
            })
        }).catch(() => {})
    })

    elements.screenControl.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        fetch(`https://${GetParentResourceName()}/triggerSetting`, {
            method: 'POST',
            body: JSON.stringify({
                key: 'screenControl'
            })
        }).catch(() => {})
    })

    elements.remoteControl.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        fetch(`https://${GetParentResourceName()}/remoteControl`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(() => {})
    })

    elements.playButton.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        if (!playing)
            fetch(`https://${GetParentResourceName()}/playerPlayed`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(() => {})
        else
            fetch(`https://${GetParentResourceName()}/playerPaused`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(() => {})
    })

    elements.stopButton.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/playerStopped`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(() => {})
    })

    elements.skipButton.on('click', e => {
        if (pendingQueue || pendingSync)
            return e.preventDefault()

        pendingQueue = true
        pendingSync = true

        fetch(`https://${GetParentResourceName()}/playerSkipped`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(() => {})
    })

    elements.loopButton.on('click', e => {
        if (pendingSync)
            return e.preventDefault()

        pendingSync = true

        fetch(`https://${GetParentResourceName()}/playerLooped`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(() => {})
    })

    elements.addButton.on('click', e => {
        if (pendingQueue)
            return e.preventDefault()
        
        const url = elements.addInput.val()

        if (url.trim() === '')
            return

        if ($('.queue-element').length >= 50)
            return notify(lang.queueLimitReached, 'error')

        const ytVideoId = url.match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/i)
        const twitchChannel = url.match(/^(?:https?:\/\/)?(?:www\.|go\.)?twitch\.tv\/([A-z0-9_]+)($|\?)/i)
        const twitchVideo = url.match(/^(?:https?:\/\/)?(?:www\.|go\.)?twitch\.tv\/videos\/([0-9]+)($|\?)/i)
        const twitchClip = url.match(/^(?:(?:^(?:https?:\/\/)?clips\.twitch\.tv\/([A-z0-9_-]+)(?:$|\?))|(?:^(?:https?:\/\/)?(?:www\.|go\.)?twitch\.tv\/(?:[A-z0-9_-]+)\/clip\/([A-z0-9_-]+)($|\?)))/i)

        urlCheckElement.value = url

        if (!urlCheckElement.validity.valid)
            notify(lang.invalidUrl, 'error')
        else if (ytVideoId && ytVideoId[1]) {
            const spinElement = $('<div class="queue-element fetching"><i class="fas fa-spinner fa-spin"></i></div>')

            elements.queue.append(spinElement)

            fetch(`https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=${ytVideoId[1]}`).then(response => response.json()).then(data => {
                if (data.provider_name === 'YouTube') {
                    pendingQueue = true

                    fetch(`https://${GetParentResourceName()}/urlAdded`, {
                        method: 'POST',
                        body: JSON.stringify({
                            thumbnailUrl: $('<div />').text(data.thumbnail_url).text(),
                            thumbnailTitle: $('<div />').text(data.author_name).text(),
                            title: $('<div />').text(data.title).text(),
                            icon: 'fab fa-youtube icon',
                            url: $('<div />').text(`https://www.youtube.com/watch?v=${ytVideoId[1]}`).text()
                        })
                    }).catch(() => {})
                }
            }).catch(e => {
                pendingQueue = false
                spinElement.fadeOut(() => spinElement.remove())
                notify(lang.invalidYouTubeUrl, 'error')
            })
        } else if (twitchChannel && twitchChannel[1]) {
            const spinElement = $('<div class="queue-element fetching"><i class="fas fa-spinner fa-spin"></i></div>')

            elements.queue.append(spinElement)

            fetch(`https://www.twitch.tv/${twitchChannel[1]}`).then(response => response.text()).then(responseText => {
                pendingQueue = true

                const parsedResponse = (new window.DOMParser()).parseFromString(responseText, 'text/html')
                const userAvatarQs = parsedResponse.querySelector('img.tw-image-avatar')
                const metaOgImageQs = parsedResponse.querySelector('meta[property="og:image"]')
                const applicationLdQs = parsedResponse.querySelector('script[type="application/ld+json"]')
                const previewImage = userAvatarQs ? userAvatarQs.getAttribute('src').replace('50x50.png', '300x300.png') : (metaOgImageQs ? metaOgImageQs.getAttribute('content') : '/client/ui/images/frame.svg')

                let liveTitle = $('<div />').text(parsedResponse.title.replace(/ - Twitch$/, '').replace(/on Twitch$/, '')).text()
                let channelOnTitle = parsedResponse.title.match(/^([a-zA-Z0-9_]+) - Twitch$/)
                let channelName = channelOnTitle && channelOnTitle.length > 1 ? channelOnTitle[1] : twitchChannel[1]

                if (liveTitle === 'Twitch')
                    throw new Error('E_CHANNEL_NOT_FOUND')
                else if (liveTitle.toLowerCase() === twitchChannel[1].toLowerCase())
                    liveTitle = lang.liveFeed

                if (applicationLdQs)
                    try {
                        const applicationLdQsJson = JSON.parse(applicationLdQs.innerText)
                        channelName = applicationLdQsJson[0].author.name
                        liveTitle = applicationLdQsJson[0].description
                    } catch (e) { }

                fetch(`https://${GetParentResourceName()}/urlAdded`, {
                    method: 'POST',
                    body: JSON.stringify({
                        thumbnailUrl: $('<div />').text(previewImage).text(),
                        thumbnailTitle: channelName,
                        title: liveTitle,
                        icon: 'fab fa-twitch icon',
                        url: $('<div />').text(`https://www.twitch.tv/${twitchChannel[1]}`).text()
                    })
                }).catch(() => {})
            }).catch(e => {
                pendingQueue = false
                spinElement.fadeOut(() => spinElement.remove())
                notify(lang.invalidTwitchUrl, 'error')
            })
        } else if (twitchVideo && twitchVideo[1]) {
            const spinElement = $('<div class="queue-element fetching"><i class="fas fa-spinner fa-spin"></i></div>')

            elements.queue.append(spinElement)

            fetch(`https://www.twitch.tv/videos/${twitchVideo[1]}`).then(response => response.text()).then(responseText => {
                pendingQueue = true

                const parsedResponse = (new window.DOMParser()).parseFromString(responseText, 'text/html')
                const userAvatarQs = parsedResponse.querySelector('img.tw-image-avatar')
                const metaOgImageQs = parsedResponse.querySelector('meta[property="og:image"]')
                const previewImage = userAvatarQs ? userAvatarQs.getAttribute('src').replace('50x50.png', '300x300.png') : (metaOgImageQs ? metaOgImageQs.getAttribute('content') : '/client/ui/images/frame.svg')
                const applicationLdQs = parsedResponse.querySelector('script[type="application/ld+json"]')

                let videoTitle = parsedResponse.title.replace(/ - Twitch$/, '').replace(/ on Twitch$/, '')
                let channelOnTitle = videoTitle.match(/- ([a-zA-Z0-9_]+)$/)
                let channelName = channelOnTitle && channelOnTitle.length > 1 ? channelOnTitle[1] : 'Twitch'

                if (videoTitle === 'Twitch')
                    videoTitle = twitchVideo[1]
                else if (channelOnTitle && channelOnTitle.length > 1)
                    videoTitle = videoTitle.replace(new RegExp(`- (${channelOnTitle[1]})$`), '')

                if (applicationLdQs)
                    try {
                        const applicationLdQsJson = JSON.parse(applicationLdQs.innerText)
                        channelName = applicationLdQsJson[0].author.name
                        videoTitle = applicationLdQsJson[0].description
                    } catch (e) { }

                fetch(`https://${GetParentResourceName()}/urlAdded`, {
                    method: 'POST',
                    body: JSON.stringify({
                        thumbnailUrl: $('<div />').text(previewImage).text(),
                        thumbnailTitle: channelName,
                        title: $('<div />').text(videoTitle).text(),
                        icon: 'fab fa-twitch icon',
                        url: $('<div />').text(`https://www.twitch.tv/videos/${twitchVideo[1]}`).text()
                    })
                }).catch(() => {})
            }).catch(e => {
                pendingQueue = false
                spinElement.fadeOut(() => spinElement.remove())
                notify(lang.invalidTwitchUrl, 'error')
            })
        } else if (twitchClip && (twitchClip[1] || twitchClip[2])) {
            const spinElement = $('<div class="queue-element fetching"><i class="fas fa-spinner fa-spin"></i></div>')

            elements.queue.append(spinElement)

            fetch(`https://clips.twitch.tv/embed?clip=${(twitchClip[1] || twitchClip[2])}`).then(response => response.text()).then(responseText => {
                const parsedResponse = (new window.DOMParser()).parseFromString(responseText, 'text/html')
                const metaOgImageQs = parsedResponse.querySelector('meta[property="og:image"]')

                pendingQueue = true

                fetch(`https://${GetParentResourceName()}/urlAdded`, {
                    method: 'POST',
                    body: JSON.stringify({
                        thumbnailUrl: $('<div />').text(metaOgImageQs ? metaOgImageQs.getAttribute('content') : '/client/ui/images/frame.svg').text(),
                        thumbnailTitle: lang.twitchClip,
                        title: (twitchClip[1] || twitchClip[2]),
                        icon: 'fab fa-twitch icon',
                        url: $('<div />').text(`https://clips.twitch.tv/embed?clip=${(twitchClip[1] || twitchClip[2])}`).text()
                    })
                }).catch(() => {})
            }).catch(e => {
                pendingQueue = false
                spinElement.fadeOut(() => spinElement.remove())
                notify(lang.invalidTwitchUrl, 'error')
            })
        } else if (allowAllSources)
            fetch(`https://${GetParentResourceName()}/urlAdded`, {
                method: 'POST',
                body: JSON.stringify({
                    thumbnailUrl: '/client/ui/images/frame.svg',
                    thumbnailTitle: lang.frame,
                    title: url,
                    icon: 'fas fa-film icon',
                    url
                })
            }).catch(() => {})
        else
            notify(lang.invalidUrl, 'error')

        elements.addInput.val('')
    })

    elements.addInput.on('keydown', e => {
        if (e.which === 13)
            elements.addButton.trigger('click')
    })

    elements.volume.on('input', e => {
        if (pendingSync) {
            elements.volume.val(elements.volume.attr('data-last-value'))
            return e.preventDefault()
        }

        pendingSync = true

        elements.volume.attr('data-last-value', elements.volume.val())
        elements.volumeText.html(`${Math.round(elements.volume.val())}%`)

        fetch(`https://${GetParentResourceName()}/changeVolume`, {
            method: 'POST',
            body: JSON.stringify({
                value: parseInt(elements.volume.val())
            })
        }).catch(() => {})
    })

    elements.seek.on('input', e => {
        if (pendingSync || pendingSeek) {
            elements.seek.val(elements.seek.attr('data-last-value'))
            return e.preventDefault()
        }

        elements.seek.attr('disabled', 'disabled')

        const minutes = Math.floor(parseInt(elements.seek.val()) / 60)
        const seconds = parseInt(elements.seek.val()) - (minutes * 60)

        pendingSeek = true
        pendingSync = true

        elements.seek.attr('data-last-value', elements.seek.val())
        elements.seekStartText.html(`${minutes > 9 ? minutes : `0${minutes}`}:${seconds > 9 ? seconds : `0${seconds}`}`)

        fetch(`https://${GetParentResourceName()}/seek`, {
            method: 'POST',
            body: JSON.stringify({
                value: parseInt(elements.seek.val())
            })
        }).catch(() => {})
    })

    elements.close.on('click', () => fetch(`https://${GetParentResourceName()}/hideUi`, {
        method: 'POST',
        body: JSON.stringify({})
    }).catch(() => {}))

    $('body').on('click', '.queue-button[data-action="queue-now"]', e => {
        if (pendingQueue || pendingSync)
            return e.preventDefault()

        pendingQueue = true
        pendingSync = true

        fetch(`https://${GetParentResourceName()}/queueNow`, {
            method: 'POST',
            body: JSON.stringify({
                index: parseInt($(e.currentTarget).parents('.queue-element:first').attr('data-index'))
            })
        }).catch(() => {})
    })

    $('body').on('click', '.queue-button[data-action="queue-next"]', e => {
        if (pendingQueue)
            return e.preventDefault()

        pendingQueue = true

        fetch(`https://${GetParentResourceName()}/queueNext`, {
            method: 'POST',
            body: JSON.stringify({
                index: parseInt($(e.currentTarget).parents('.queue-element:first').attr('data-index'))
            })
        }).catch(() => {})
    })

    $('body').on('click', '.queue-button[data-action="queue-remove"]', e => {
        if (pendingQueue)
            return e.preventDefault()

        pendingQueue = true

        fetch(`https://${GetParentResourceName()}/queueRemove`, {
            method: 'POST',
            body: JSON.stringify({
                index: parseInt($(e.currentTarget).parents('.queue-element:first').attr('data-index'))
            })
        }).catch(() => {})
    })

    $('body').on('blur', 'input[type="text"]', () => fetch(`https://${GetParentResourceName()}/inputBlur`, {
        method: 'POST',
        body: JSON.stringify({})
    }).catch(() => {}))

    $('body').on('focus', 'input[type="text"]', () => fetch(`https://${GetParentResourceName()}/inputFocus`, {
        method: 'POST',
        body: JSON.stringify({})
    }).catch(() => {}))

    window.addEventListener('message', e => {
        switch (e.data.type) {
            case 'cs-hall:show':
                $('body').show()

                allowAllSources = e.data.allowAllSources

                elements.addInput.attr('placeholder', allowAllSources ? lang.allUrlPlaceholder : lang.urlPlaceholder)

                if (elements.seek.attr('max') !== '0' && elements.seekControl.css('bottom') === '0px')
                    setTimeout(() => {
                        if (elements.seek.attr('max') !== '0' && elements.seekControl.css('bottom') === '0px' && (!stopped))
                            elements.seekControl.css('bottom', `${elements.playerContainer.height()}px`)
                    }, 1000)

                break

            case 'cs-hall:hide':
                $('body').hide()
                break

            case 'cs-hall:sync':
                playing = e.data.media.playing
                stopped = e.data.media.stopped

                $('.enabled').removeClass('enabled')
                $('.disabled').removeClass('disabled')

                if (playing) {
                    elements.playButton.html('<i class="fas fa-pause"></i>')
                    elements.playButton.get(0)._tippy.setContent(lang.pause)
                    elements.playButton.addClass('enabled')
                } else {
                    elements.playButton.html('<i class="fas fa-play"></i>')
                    elements.playButton.get(0)._tippy.setContent(lang.play)
                }

                elements.volume.val(Math.round(e.data.media.volume * 100))
                elements.volume.attr('data-last-value', elements.volume.val())
                elements.volumeText.html(`${Math.round(elements.volume.val())}%`)

                if (e.data.media.loop)
                    elements.loopButton.addClass('enabled')

                if (e.data.settings.scenesEnabled)
                    elements.scenesEnabled.addClass('enabled')
                else
                    elements.scenesEnabled.addClass('disabled')

                if (e.data.settings.bassSmoke)
                    elements.bassSmoke.addClass('enabled')
                else
                    elements.bassSmoke.addClass('disabled')

                if (e.data.settings.bassSparklers)
                    elements.bassSparklers.addClass('enabled')
                else
                    elements.bassSparklers.addClass('disabled')

                if (e.data.settings.whiteSpotlights)
                    elements.whiteSpotlights.addClass('enabled')
                else
                    elements.whiteSpotlights.addClass('disabled')

                if (e.data.settings.dynamicSpotlights)
                    elements.dynamicSpotlights.addClass('enabled')
                else
                    elements.dynamicSpotlights.addClass('disabled')

                if (e.data.settings.photorythmicSpotlights)
                    elements.photorythmicSpotlights.addClass('enabled')
                else
                    elements.photorythmicSpotlights.addClass('disabled')

                if (e.data.settings.videoToggle)
                    elements.videoToggle.addClass('enabled')
                else
                    elements.videoToggle.addClass('disabled')

                if (e.data.remoteControl)
                    elements.remoteControl.addClass('enabled')
                else
                    elements.remoteControl.addClass('disabled')

                if (!e.data.media.url) {
                    elements.mediaTitle.fadeOut(() => elements.mediaTitle.html(''))
                    elements.mediaImage.fadeOut(() => elements.mediaImage.html(''))

                    const jsElement = $(elements.mediaInfo).get(0)

                    if (jsElement._tippy)
                        jsElement._tippy.destroy()
                } else {
                    elements.mediaTitle.html(e.data.media.title).fadeIn()
                    elements.mediaImage.html(`<img src="${e.data.media.thumbnailUrl}" alt="${e.data.media.thumbnailUrl}" />`).fadeIn()

                    const jsElement = $(elements.mediaInfo).get(0)

                    if (jsElement._tippy)
                        jsElement._tippy.destroy()

                    if (e.data.media.thumbnailTitle || e.data.media.icon)
                        tippy(jsElement, {
                            allowHTML: true,
                            content: `${e.data.media.icon ? `<i class="icon ${e.data.media.icon}"></i>${e.data.media.thumbnailTitle ? `&nbsp;&nbsp;${e.data.media.thumbnailTitle}` : ''}` : e.data.media.thumbnailTitle}`,
                            placement: 'left'
                        })

                    const ytVideoId = e.data.media.url.match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/i)
                    const twitchChannel = e.data.media.url.match(/^(?:https?:\/\/)?(?:www\.|go\.)?twitch\.tv\/([A-z0-9_]+)($|\?)/i)
                    const twitchVideo = e.data.media.url.match(/^(?:https?:\/\/)?(?:www\.|go\.)?twitch\.tv\/videos\/([0-9]+)($|\?)/i)
                    const twitchClip = e.data.media.url.match(/^(?:(?:^(?:https?:\/\/)?clips\.twitch\.tv\/([A-z0-9_-]+)(?:$|\?))|(?:^(?:https?:\/\/)?(?:www\.|go\.)?twitch\.tv\/(?:[A-z0-9_-]+)\/clip\/([A-z0-9_-]+)($|\?)))/i)

                    let identifier = ''

                    if (ytVideoId && ytVideoId[1])
                        identifier = `YouTube:${ytVideoId[1]}`
                    else if (twitchChannel && twitchChannel[1])
                        identifier = `TwitchChannel:${twitchChannel[1]}`
                    else if (twitchVideo && twitchVideo[1])
                        identifier = `TwitchVideo:${twitchVideo[1]}`
                    else if (twitchClip && twitchClip[1])
                        identifier = `TwitchClip:${twitchClip[1]}`
                    
                    if (identifier !== '')
                        fetch(`https://${GetParentResourceName()}/setSceneIdentifier`, {
                            method: 'POST',
                            body: JSON.stringify({
                                identifier
                            })
                        }).catch(() => {})
                }

                if ((!e.data.media.url) || e.data.media.stopped || e.data.media.url !== lastUrl) {
                    pendingSeek = false

                    if (!seekHiding) {
                        seekHiding = true

                        elements.seek.attr('disabled', 'disabled')

                        elements.seekControl.css('bottom', '0px')
                        elements.seek.attr('max', 0).val(0)
                        elements.seekStartText.html('00:00')
                        elements.seekEndText.html('00:00')

                        seekHiding = false
                    }
                }

                lastUrl = e.data.media.url
                
                elements.remoteControl.animate({
                    opacity: 1
                }, 250)

                if (e.data.hasScreens)
                    elements.screenControl.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')
                else
                    elements.screenControl.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')

                if (e.data.hasSmokers) {
                    if (e.data.hasAutoSmokers)
                        elements.bassSmoke.animate({
                            opacity: 1
                        }, 250).css('pointer-events', 'auto')
                    else
                        elements.bassSmoke.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')

                    elements.triggerSmoke.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')
                } else {
                    elements.bassSmoke.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')
                    elements.triggerSmoke.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')
                }

                if (e.data.hasSparklers) {
                    if (e.data.hasAutoSparklers)
                        elements.bassSparklers.animate({
                            opacity: 1
                        }, 250).css('pointer-events', 'auto')
                    else
                        elements.bassSparklers.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')

                    elements.triggerSparklers.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')
                } else {
                    elements.bassSparklers.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')
                    elements.triggerSparklers.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')
                }

                if (e.data.hasSpotlights) {
                    elements.whiteSpotlights.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')

                    elements.dynamicSpotlights.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')

                    elements.photorythmicSpotlights.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')
                } else {
                    elements.whiteSpotlights.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')

                    elements.dynamicSpotlights.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')

                    elements.photorythmicSpotlights.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')
                }

                if (e.data.hasSpeakers)
                    elements.volumeControl.animate({
                        opacity: 1
                    }, 250).css('pointer-events', 'auto')
                else
                    elements.volumeControl.animate({
                        opacity: 0
                    }, 250).css('pointer-events', 'none')

                pendingSync = false

                break

            case 'cs-hall:info':
                if (pendingSeek || seekHiding)
                    return

                if ((!e.data.duration) || e.data.duration === -1 || stopped) {
                    if (elements.seekControl.css('bottom') === '0px')
                        return

                    seekHiding = true

                    elements.seek.attr('disabled', 'disabled')
                    elements.seekControl.css('bottom', '0px')
                    elements.seek.attr('max', 0).val(0)
                    elements.seekStartText.html('00:00')
                    elements.seekEndText.html('00:00')

                    seekHiding = false
                } else {
                    const time = Math.round(e.data.time)
                    const timeMinutes = Math.floor(time / 60)
                    const timeSeconds = time - (timeMinutes * 60)
                    const duration = Math.round(e.data.duration)
                    const durationMinutes = Math.floor(duration / 60)
                    const durationSeconds = duration - (durationMinutes * 60)
    
                    elements.seek.attr('max', duration).val(time).attr('data-last-value', time)
                    elements.seekStartText.html(`${timeMinutes > 9 ? timeMinutes : `0${timeMinutes}`}:${timeSeconds > 9 ? timeSeconds : `0${timeSeconds}`}`)
                    elements.seekEndText.html(`${durationMinutes > 9 ? durationMinutes : `0${durationMinutes}`}:${durationSeconds > 9 ? durationSeconds : `0${durationSeconds}`}`)

                    elements.seek.removeAttr('disabled')

                    if ($('body').is(':visible') && elements.seekControl.css('bottom') === '0px')
                        setTimeout(() => {
                            if ($('body').is(':visible') && elements.seekControl.css('bottom') === '0px' && (!stopped))
                                elements.seekControl.css('bottom', `${elements.playerContainer.height()}px`)
                        }, 1000)
                }

                break

            case 'cs-hall:seeked':
                pendingSeek = false
                elements.seek.removeAttr('disabled')

                break

            case 'cs-hall:queue':
                elements.queue.html('')

                for (let index = 0; index < e.data.queue.length; index++) {
                    const q = e.data.queue[index]
                    const element = $(`<div class="queue-element" data-index="${index + 1}"><div class="queue-image" style="background-image:url(${q.thumbnailUrl})"></div><div class="queue-actions"><div class="queue-title">${q.title}</div><div class="queue-buttons"><span class="queue-button" data-action="queue-now"><i class="fas fa-play"></i> ${lang.queueNow}</span><span class="queue-button" data-action="queue-next"><i class="fas fa-step-forward"></i> ${lang.queueNext}</span><span class="queue-button" data-action="queue-remove"><i class="fas fa-times"></i> ${lang.remove}</span></div></div></div>`)

                    elements.queue.append(element)

                    if (q.thumbnailTitle || q.icon)
                        tippy($(element).get(0), {
                            allowHTML: true,
                            content: `${q.icon ? `<span class="tooltip-icon"><i class="${q.icon}"></i></span> ` : ''}${q.thumbnailTitle ? `${q.icon ? '&nbsp;' : ''}${q.thumbnailTitle}` : ''}`,
                            placement: 'left'
                        })
                }

                pendingQueue = false

                break

            case 'cs-hall:error':
                notify(e.data.error, 'error')
                break
        }
    })

    elements.queue.on('scroll', e => tippy.hideAll({
        duration: 50
    }))

    window.addEventListener('keyup', e => {
        switch (e.key) {
            case 'Escape':
                fetch(`https://${GetParentResourceName()}/hideUi`, {
                    method: 'POST',
                    body: JSON.stringify({})
                }).catch(() => {})

                break

            case 'Backspace':
                if ($(':focus').length === 0)
                    fetch(`https://${GetParentResourceName()}/hideUi`, {
                        method: 'POST',
                        body: JSON.stringify({})
                    }).catch(() => {})

                break
        }
    })

    window.addEventListener('keydown', e => {
        switch (e.key) {
            case 'ArrowLeft':
            case 'ArrowRight':
            case 'ArrowUp':
            case 'ArrowDown':
                e.preventDefault()
                break
        }
    })
}

window.addEventListener('message', e => {
    switch (e.data.type) {
        case 'cs-hall:ready':
            ready(e.data.lang)
            break
    }
})

fetch(`https://${GetParentResourceName()}/nuiReady`, {
    method: 'POST',
    body: JSON.stringify({})
}).catch(() => {})
