import 'dart:collection';

class Queue {
    int _current;
    LinkedHashSet<String> _q;

    void addToQueue(String song) => this._q.add(song);

    void moveTo(String song) => this._current = indexOf(song, _q);

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

int indexOf(String song, LinkedHashSet<String> q) {
    for (int i=0; i<q.length; i++)
        if (q.elementAt(i) == song)
            return i;
}
