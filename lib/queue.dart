import 'package:flutter_audio_query/flutter_audio_query.dart';

class _Queue {
    bool playing = false;
    bool shuffle = false;
    int _current = 0;
    List<SongInfo> _q = [];

    List<SongInfo> get songs => this._q;

    void play(Iterable<SongInfo> songs) {
        this._q.clear();
        this._q.addAll(songs);
        this.playing = true;
    }

    void toggleShuffle() => this.shuffle ^= true;

    void togglePlayPause() => this.playing ^= true;

    void addToQueue(SongInfo song) => this._q.add(song);

    void moveTo(SongInfo song) {
        if (!this._q.contains(songs)) return;
        this._current = this._q.indexOf(song);
    }

    void playNext(SongInfo song) {
        if (!this._q.contains(songs)) return;
        if (this._q.indexOf(song) == this._current)
            return;
        this._q.remove(song);
        if (this._current < this._q.length-1)
            this._q.insert(_current+1, song);
        else
            this._q.add(song);
    }

    void remove(SongInfo song) {
        if (!this._q.contains(songs)) return;
        this._q.remove(song);
    }

    void seek() {} // go to xx:xx in song

    void next() {
        if (this.shuffle) {

        } else {
            this._current++;
            if (this._current >= this._q.length)
                this._current = 0; // loop around
        }
    }

    void previous() {
        if (this.shuffle) {

        } else {
            this._current--;
            if (this._current <= 0)
                this._current = this._q.length-1; // loop around
        }
    }
}

_Queue globalQueue = _Queue();
