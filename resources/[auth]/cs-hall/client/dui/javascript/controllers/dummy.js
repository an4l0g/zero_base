class DummyController {
    constructor(manager, ready) {
        this.key = 'dummy'
        this.playing = false
        this.seeking = false
        this.manager = manager
        
        this.pending = {
            stop: false,
            play: false,
            pause: false,
            seek: false
        }

        this.ready = ready
    }

    hook() {}

    play(muted) {}

    pause() {}

    stop() {}

    seek(time) {}

    set(source) {}

    screenshot() {
        return null
    }

    dynamic() {
        return false
    }

    time() {
        return null
    }

    seeked() {
        if (!this.seeking)
            return
        
        this.seeking = false
        this.manager.controllerSeeked(this)
    }

    controls(mediaSession) {
        mediaSession.setActionHandler('play', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'play'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('pause', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'pause'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('stop', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'stop'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('seekbackward', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'seekbackward'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('seekforward', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'seekforward'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('seekto', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'seekto'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('previoustrack', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'previoustrack'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('nexttrack', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'nexttrack'
            })
        }).catch(error => {}))

        mediaSession.setActionHandler('skipad', () => fetch(`https://${resourceName}/mediaKey`, {
            method: 'POST',
            body: JSON.stringify({
                type: 'skipad'
            })
        }).catch(error => {}))
    }

    show() {}

    hide() {}
}
