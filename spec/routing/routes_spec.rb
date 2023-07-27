require 'rails_helper'

RSpec.describe 'Routes', type: :routing do

  it 'routes to assign_team action in users controller' do
    expect(put: '/users/1/assign_team').to route_to('users#assign_team', id: '1')
  end

  it 'routes to teams resources' do
    expect(get: '/teams').to route_to('teams#index')
    expect(post: '/teams').to route_to('teams#create')
  end

  it 'routes to join action in teams controller' do
    expect(post: '/teams/1/join').to route_to('teams#join', id: '1')
  end

  it 'routes to update_manager action in teams controller' do
    expect(patch: '/teams/1/update_manager').to route_to('teams#update_manager', id: '1')
  end

  it 'routes to remove_member action in teams controller' do
    expect(delete: '/teams/1/remove_member').to route_to('teams#remove_member', id: '1')
  end

  it 'routes to delete_team action in teams controller' do
    expect(delete: '/teams/1').to route_to('teams#delete_team', id: '1')
  end

  it 'routes to create_note action in teams controller' do
    expect(post: '/teams/1/create_note').to route_to('teams#create_note', id: '1')
  end

  it 'routes to leave_team action in teams controller' do
    expect(delete: '/teams/1/leave_team').to route_to('teams#leave_team', id: '1')
  end

  it 'routes to teams action in users controller' do
    expect(get: '/users/1/teams').to route_to('users#teams', id: '1')
  end

  it 'routes to notes resources' do
    expect(get: '/notes').to route_to('notes#index')
    expect(get: '/notes/new').to route_to('notes#new')
    expect(post: '/notes').to route_to('notes#create')
    expect(get: '/notes/1').to route_to('notes#show', id: '1')
    expect(get: '/notes/1/edit').to route_to('notes#edit', id: '1')
    expect(patch: '/notes/1').to route_to('notes#update', id: '1')
    expect(put: '/notes/1').to route_to('notes#update', id: '1')
  end

  it 'routes to delete_note action in notes controller' do
    expect(delete: '/notes/1').to route_to('notes#destroy', id: '1')
  end

  it 'routes to update_note_access action in notes controller' do
    expect(patch: '/teams/1/notes/1/update_note_access').to route_to('notes#update_note_access', team_id: '1', id: '1')
  end

  it 'routes to update_role action in users controller' do
    expect(patch: '/users/1/update_role').to route_to('users#update_role', id: '1')
  end

  it 'routes to dashboard' do
    expect(get: '/dashboard').to route_to('dashboard#index')
  end

  it 'routes to your_teams' do
    expect(get: '/your_teams').to route_to('teams#your_teams')
  end

  it 'routes to joined_teams' do
    expect(get: '/joined_teams').to route_to('teams#joined_teams')
  end

  it 'routes to root' do
    expect(get: '/').to route_to('dashboard#index')
  end
end
