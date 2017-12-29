import Vue from 'vue/dist/vue';
import Rx from 'rx-dom';
import moment from 'moment';

const id = 'ticketsTable';

const entryFromAttrs = ({ inserted_at, description, amount, links }) => {
  return { date: moment(inserted_at).format('L'), description, amount, links };
};

const run = () => {
  const studentId = document.getElementById(id).getAttribute('data-student-id');

  const app = new Vue({
    el: `#${id}`,
    data: {
      pageNumber: 1,
      totalPages: 1,
      csrf: '',
      entries: []
    },
    methods: {
      // TODO: Finish delete implementation
      deleteEntry(entry) {
        if (!window.confirm('Are you sure?')) { return; }

        Rx.DOM.ajax({
          url: entry.links.delete,
          method: 'POST',
          headers: { 'X-CSRF-Token': this.csrf },
          body: { _csrf_token: this.csrf, _method: 'delete' }
        }).subscribe(
          (data) => console.log(data),
          (error) => console.log(error),
        );
      },

      nextPage() {
        this.pageNumber = Math.min(this.totalPages, this.pageNumber + 1);
        this.update();
      },

      previousPage() {
        this.pageNumber = Math.max(1, this.pageNumber - 1);
        this.update();
      },

      update() {
        Rx.DOM.getJSON(`/api/students/${studentId}/tickets?page=${this.pageNumber || 1}`)
          .map((data) => {
            return { ...data, entries: data.entries.map(entryFromAttrs) };
          })
          .subscribe(
            (data) => {
              this.entries = data.entries;
              this.csrf = data.csrf;
              this.pageNumber = data.page.page_number;
              this.totalPages = data.page.total_pages;
            },
            (error) => console.error(error)
          );
      }
    }
  });
  app.update();
};

module.exports = { id, run };
