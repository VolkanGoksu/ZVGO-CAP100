sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"zvgobookstorelistview/test/integration/pages/BooksList",
	"zvgobookstorelistview/test/integration/pages/BooksObjectPage"
], function (JourneyRunner, BooksList, BooksObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('zvgobookstorelistview') + '/test/flpSandbox.html#zvgobookstorelistview-tile',
        pages: {
			onTheBooksList: BooksList,
			onTheBooksObjectPage: BooksObjectPage
        },
        async: true
    });

    return runner;
});

