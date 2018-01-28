$(window).load(function() {
  $('#tweetTable').hide();
  $('#statistics').hide();
});

$(function() {
  $('#searchButton').click((e) => {
    let input = $('#searchInput').val();
    if (input.length == 0) {
      return;
    }
    let parameters = {inputValue: input};
    $.post('/search', parameters, (data) => {
      console.log(data);
      $('#tweetTable tbody tr').remove();
      let rowNumber = 1;
      for (tweet of data.tweets) {
        $('#tweetTable > tbody:last-child').append('<tr><td>' + rowNumber + '</td><td>' + tweet + '</td></tr>');
        rowNumber++;
      }
      let hashtagCount = 0;
      for (hashtag of data.hashtags) {
        $('#statistics').children().eq(hashtagCount).children().eq(0).html(hashtag[1]);
        $('#statistics').children().eq(hashtagCount).children().eq(1).html(hashtag[0]);
        hashtagCount++;
      }
      $('#tweetTable').show();
      $('#statistics').show();
    });
  });
});
