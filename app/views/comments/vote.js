<% if @vote.valid? %>
  $('#comment_<%= @comment.id %>_votebox > #votes').html("<strong><%= @comment.total_votes %></strong> <small>(<%= pluralize(@comment.votes.size, "Vote")%>)</small>");
  <% if @vote.vote %>
    $('#comment_<%= @comment.id %>_votebox > #voteup').html("<%= escape_javascript(link_based_on_current_users_vote_on_comment(@comment, true) ) %>");
  <% else %>
    $('#comment_<%= @comment.id %>_votebox > #votedown').html("<%= escape_javascript(link_based_on_current_users_vote_on_comment(@comment, false) ) %>");
  <% end %>
<% else %>
  alert("You have already voted on that comment!");
<% end %>
