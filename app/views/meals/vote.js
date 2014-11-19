<% if @vote.valid? %>
  $('#meal_<%= @meal.slug %>_votebox > #votes').html("<strong><%= @meal.total_votes %></strong> <small>(<%= pluralize(@meal.votes.size, "Vote")%>)</small>");
  <% if @vote.vote %>
    $('#meal_<%= @meal.slug %>_votebox > #voteup').html("<%= escape_javascript(link_based_on_current_users_vote_on_meal(@meal, true) ) %>");
  <% else %>
    $('#meal_<%= @meal.slug %>_votebox > #votedown').html("<%= escape_javascript(link_based_on_current_users_vote_on_meal(@meal, false) ) %>");
  <% end %>
<% else %>
  alert("You have already voted on that meal!");
<% end %>
