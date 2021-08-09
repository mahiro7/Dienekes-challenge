defmodule ChallengeWeb.NumbersView do
  use ChallengeWeb, :view
  alias ChallengeWeb.NumbersView

  def render("requesting.json", _) do
    "Requesting and sorting numbers... it may take several minutes"
  end

  def render("index.json", %{list: list}) do
    %{data: render_many(list, NumbersView, "numbers.json")}
  end

  def render("cshow.json", %{numbers: numbers}) do
    %{data: render_one(numbers, NumbersView, "numbers.json")}
  end

  def render("show.json", %{numbers: numbers}) do
    %{data: render_many(numbers, NumbersView, "numbers.json")}
  end

  def render("numbers.json", %{numbers: numbers}) do
    %{
      numbers: numbers.numbers}
  end
end
