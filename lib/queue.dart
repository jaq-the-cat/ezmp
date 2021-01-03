import 'dart:collection';

class _Queue {
    bool playing = false;
    bool shuffle = false;
    int _current = 0;
    List<String> _q = [];

    void togglePlayPause() => this.playing ^= true;

    void toggleShuffle() {
        this.shuffle = true;
    }

    void addToQueue(String song) => this._q.add(song);

    void moveTo(String song) => this._current = this._q.indexOf(song);

    void playNext(String song) {
        this._q.remove(song);
        if (this._current < this._q.length-1)
            this._q.insert(_current+1, song);
        else
            this._q.add(song);
    }

    void remove(String song) => this._q.remove(song);

    void seek() {} // go to xx:xx in song

    void next() {
        this._current++;
        if (this._current >= this._q.length)
            this._current = 0; // loop around
    }

    void previous() {
        this._current--;
        if (this._current <= 0)
            this._current = this._q.length-1; // loop around
    }
}

_Queue globalQueue = _Queue();
